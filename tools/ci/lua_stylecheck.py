# ===========================================================================
#
#  Copyright (c) 2022 LandSandBoat Dev Teams
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see http://www.gnu.org/licenses/
#
# ===========================================================================

import glob
import re
import sys
import os
import importlib
import inspect

def contains_word(word):
    return re.compile(r'\b({0})\b'.format(word)).search

def load_visitors():
    visitors = []
    rules_dir = os.path.join(os.path.dirname(__file__), "rules")
    from rules.lua_style_visitor import LuaStyleVisitor
    for file in sorted(os.scandir(rules_dir), key=lambda e: e.name):
        if file.name.endswith(".py") and file.name != "__init__.py":
            module_name = f"rules.{file.name[:-3]}"
            module = importlib.import_module(module_name)
            for name, obj in inspect.getmembers(module, inspect.isclass):
                # Only add classes that inherit from LuaStyleVisitor and are not the base class itself
                if issubclass(obj, LuaStyleVisitor) and obj is not LuaStyleVisitor:
                    visitors.append(obj())
    return visitors

# Context object for Lua style checks
class LuaStyleContext:
    """
    Holds shared state for style check visitors, including errors, filename, and line counter.
    All visitors should use this context to report errors and access file information.
    Adds preprocessed line variants for style checks.
    """
    def __init__(self, filename, show_errors=True):
        self.filename = filename
        self.show_errors = show_errors
        self.errors = []
        self.lines = []
        self.counter = 0
        self.line_raw = ""
        self.line_no_comments = ""
        self.line_no_comments_or_strings = ""
        self.in_condition = False
        self.full_condition = ""

    def preprocess_line(self, line):
        self.line_raw = line
        self.line_no_comments = line.split('--')[0].rstrip()
        self.line_no_comments_or_strings = re.sub(r'\"([^\"]*?)\"', "strVal", self.line_no_comments)
        self.line_no_comments_or_strings = re.sub(r"\'([^\"]*?)\'", "strVal", self.line_no_comments_or_strings)

    def error(self, error_string, suppress_line_ref=False):
        """Report an error and optionally print it."""
        self.errors.append((error_string, self.filename, self.counter))
        if self.show_errors:
            print(f"{error_string}: {self.filename}:{self.counter}")
            if not suppress_line_ref and self.counter > 0 and self.counter <= len(self.lines):
                print(f"{self.lines[self.counter - 1].strip()}                              <-- HERE")
            print("")

def should_skip_file(filename):
    # Normalize path and check for /scripts/specs in any part
    return "/specs/" in filename

class LuaStyleCheck:
    def __init__(self, input_file, show_errors=True):
        self.context = LuaStyleContext(input_file, show_errors)
        self.run_style_check()

    def error(self, error_string, suppress_line_ref = False):
        self.context.error(error_string, suppress_line_ref)

    def run_style_check(self):
        if should_skip_file(self.context.filename):
            return
        if self.context.filename is None:
            print("ERROR: No filename provided to LuaStyleCheck class.")
            return
        with open(self.context.filename, 'r') as f:
            self.context.lines = f.readlines()
            visitors = load_visitors()
            # Separate out ConditionalFormattingVisitor
            conditional_visitor = None
            other_visitors = []
            for v in visitors:
                if v.__class__.__name__ == "ConditionalFormattingVisitor":
                    conditional_visitor = v
                else:
                    other_visitors.append(v)
            in_block_comment = False
            uses_id = False
            has_id_ref = False
            for line in self.context.lines:
                self.context.counter += 1
                # Ignore Block Comments
                if "[[" in line:
                    in_block_comment = True
                if "]]" in line:
                    in_block_comment = False
                if in_block_comment:
                    continue
                self.context.preprocess_line(line)
                # Multi-line condition accumulation logic
                code_line = line.strip()
                code_line_no_comments = line.split('--')[0]
                # Do not strip newlines when building full_condition
                if self.context.in_condition:
                    self.context.full_condition += code_line_no_comments + '\n'
                    if re.search(r"\bthen\b", code_line_no_comments):
                        # End of condition block, check it
                        if conditional_visitor:
                            conditional_visitor.visit(self.context.full_condition, self.context)
                        self.context.in_condition = False
                        self.context.full_condition = ""
                elif re.search(r'\b(if|elseif)\b', code_line_no_comments):
                    self.context.in_condition = True
                    self.context.full_condition = code_line_no_comments + '\n'
                    # Single-line condition
                    if re.search(r'\bthen\b', code_line_no_comments):
                        if conditional_visitor:
                            conditional_visitor.visit(self.context.full_condition, self.context)
                        self.context.in_condition = False
                        self.context.full_condition = ""
                # Only run other visitors (not ConditionalFormattingVisitor) on each line
                for visitor in other_visitors:
                    visitor.visit(line, self.context)
            if "DefaultActions" not in self.context.filename and uses_id == True and not has_id_ref:
                self.error("ID variable is assigned but unused", suppress_line_ref = True)
        return

    @property
    def errcount(self):
        return len(self.context.errors)


### TODO:
# No useless parens (paren without and|or in entire section)
# Parentheses must have and|or in conditions
# Only 1 space before and after comparators
# No empty in-line comments

target = sys.argv[1]

total_errors    = 0
expected_errors = 0

if target == 'modules':
    for filename in glob.iglob('modules/**/*.lua', recursive = True):
        total_errors += LuaStyleCheck(filename).errcount
elif target == 'scripts':
    for filename in glob.iglob('scripts/**/*.lua', recursive = True):
        total_errors += LuaStyleCheck(filename).errcount
elif target == 'test':
    total_errors = LuaStyleCheck('tools/ci/tests/stylecheck.lua', show_errors = True).errcount
    expected_errors = 96
else:
    total_errors = LuaStyleCheck(target).errcount

if total_errors != expected_errors:
    if target != 'test':
        print(f"Lua styling errors: {total_errors}")
    else:
        print(f"Stylecheck Unit tests failed! Expected {expected_errors} errors and found {total_errors}.")
