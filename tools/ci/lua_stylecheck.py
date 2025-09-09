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
import regex
import sys

# [["deprecated func", "suggested replacement"], ...]
deprecated_functions = [
    ["table.getn", "#t"],
    ["os.time", "GetSystemTime"],
]

deprecated_requires = [
    "scripts/globals/items",
    "scripts/globals/keyitems",
    "scripts/globals/loot",
    "scripts/globals/msg",
    "scripts/globals/settings",
    "scripts/globals/spell_data",
    "scripts/globals/status",
    "scripts/globals/titles",
    "scripts/globals/zone",
    "scripts/enum",
    "IDs",
]

invalid_enums = [
    "xi.items.",
    "xi.effects.",
]

# 'functionName' : [ noNumberInParamX, noNumberInParamY, ... ],
# Parameters are 0-indexed
disallowed_numeric_parameters = {
    "addItem"                 : [ 0 ],
    "addKeyItem"              : [ 0 ],
    "addSpell"                : [ 0 ],
    "addStatusEffect"         : [ 0 ],
    "addStatusEffectSilent"   : [ 0 ],
    "addUsedItem"             : [ 0 ],
    "canLearnSpell"           : [ 0 ],
    "delItem"                 : [ 0 ],
    "delContainerItems"       : [ 0 ],
    "delKeyItem"              : [ 0 ],
    "delSpell"                : [ 0 ],
    "delStatusEffect"         : [ 0 ],
    "delStatusEffectEx"       : [ 0 ],
    "delUniqueEvent"          : [ 0 ],
    "getEquipID"              : [ 0 ],
    "getEquippedItem"         : [ 0 ],
    "getItemQty"              : [ 0 ],
    "hasCompletedUniqueEvent" : [ 0 ],
    "hasItem"                 : [ 0 ],
    "hasItemQty"              : [ 0 ],
    "hasSpell"                : [ 0 ],
    "messageBasic"            : [ 0 ],
    "messageName"             : [ 0 ],
    "messageSpecial"          : [ 0 ],
    "messageText"             : [ 0 ],
    "npcUtil.giveKeyItem"     : [ 1, 2 ],
    "npcUtil.giveItem"        : [ 1 ],
    "npcUtil.tradeHas"        : [ 1 ],
    "npcUtil.tradeHasExactly" : [ 1 ],
    "setUniqueEvent"          : [ 0 ],
    "showText"                : [ 0 ],
}

# Disallowed keys for reward tables
disallowed_keys = [
    "ki", 
    "xp",
]

def contains_word(word):
    return re.compile(r'\b({0})\b'.format(word)).search

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
        self.line_no_strings = ""
        self.line_no_comments_or_strings = ""
        # Multi-line condition state
        self.in_condition = False
        self.full_condition = ""

    def preprocess_line(self, line):
        self.line_raw = line
        self.line_no_comments = line.split('--')[0]
        quote_regex = regex.compile(r'"(([^\""]+)|(?R))*+"|\'(([^\'\']+)|(?R))*+\'', re.S)
        self.line_no_strings = regex.sub(quote_regex, "", line)
        self.line_no_comments_or_strings = regex.sub(quote_regex, "", self.line_no_comments)

    def error(self, error_string, suppress_line_ref=False):
        """Report an error and optionally print it."""
        self.errors.append((error_string, self.filename, self.counter))
        if self.show_errors:
            print(f"{error_string}: {self.filename}:{self.counter}")
            if not suppress_line_ref and self.counter > 0 and self.counter <= len(self.lines):
                print(f"{self.lines[self.counter - 1].strip()}                              <-- HERE")
            print("")

# Visitor base class for Lua style checks
class LuaStyleVisitor:
    """
    Base class for all Lua style check visitors.
    Each visitor should implement the visit(line, context) method.
    The visitor pattern allows modular, maintainable, and extensible style checks.
    Provides helpers for stripping comments and string literals from lines.
    """
    def strip_comments(self, line):
        return line.split('--')[0]

    def strip_strings(self, line):
        quote_regex = regex.compile(r'"(([^"\"]+)|(?R))*+"|\'(([^\'\']+)|(?R))*+\'', re.S)
        return regex.sub(quote_regex, "", line)

    def strip_comments_and_strings(self, line):
        return self.strip_strings(self.strip_comments(line))

    def visit(self, line, context):
        raise NotImplementedError("Each visitor must implement the visit method.")

# Example usage:
# class RewardTableVisitor(LuaStyleVisitor):
#     def __init__(self):
#         self.in_reward_table = False
#         self.brace_count = 0
#         self.pending_reward_table = False
#     def visit(self, line, context):
#         # ...logic here...
#         pass

class RewardTableVisitor(LuaStyleVisitor):
    """
    Visitor for quest/mission.reward table checks.
    Tracks entry/exit of reward tables and checks for disallowed keys.
    """
    def __init__(self):
        self.in_reward_table = False
        self.brace_count = 0
        self.pending_reward_table = False

    def visit(self, line, context):
        # Detect assignment to quest.reward or mission.reward (brace may be on next line)
        if not self.in_reward_table:
            if re.search(r'(quest|mission)\.reward\s*=\s*$', line.strip()):
                self.pending_reward_table = True
                return
            if re.search(r'(quest|mission)\.reward\s*=\s*\{', line):
                self.in_reward_table = True
                self.brace_count = line.count('{') - line.count('}')
                self._check_keys(line, context)
                return
        if self.pending_reward_table:
            if '{' in line:
                self.in_reward_table = True
                self.brace_count = line.count('{') - line.count('}')
                self.pending_reward_table = False
                self._check_keys(line, context)
                return
        if self.in_reward_table:
            self.brace_count += line.count('{') - line.count('}')
            self._check_keys(line, context)
            if self.brace_count <= 0:
                self.in_reward_table = False
                self.brace_count = 0

    def _check_keys(self, line, context):
        for key in disallowed_keys:
            if re.search(rf'\b{key}\s*=', line):
                context.error(f"Found disallowed key '{key}' in reward table", suppress_line_ref=False)

class ConditionalFormattingVisitor(LuaStyleVisitor):
    """
    Visitor for conditional formatting checks.
    Checks formatting of a full multi-line condition string.
    """
    def visit(self, condition, context):
        condition_str = condition.replace('elseif','').replace('if','').replace('then','').strip()
        paren_regex = regex.compile(r"\((([^\)\(]+)|(?R))*+\)", re.S)
        removed_paren_str = regex.sub(paren_regex, "", condition_str)
        if removed_paren_str == "":
            context.error("Outer parentheses should be removed in condition")
        if re.search(r"== true|== false|~= true|~= false", condition):
            context.error("Boolean with explicit value check")
        if re.search(r" and | or ", condition) and len(condition) > 72:
            context.error("Multiline conditional format required")

class TableFormattingVisitor(LuaStyleVisitor):
    """
    Visitor for table formatting checks.
    Checks for Allman brace style and proper spacing in table definitions.
    Uses comment-stripped line for regex checks to avoid interference from comments.
    """
    def visit(self, line, context):
        line_nc = context.line_no_comments
        # [ ]{0,}=[ ]{0,}\{[ ]{0,}$ : Incorrectly defined table (opening brace not on its own line)
        if re.search(r"[ ]{0,}=[ ]{0,}\{[ ]{0,}$", line_nc):
            context.error("Incorrectly defined table")
        # \{[^ \n\}] : Table opened without space or newline
        for _ in re.finditer(r"\{[^ \n\}]", line_nc):
            context.error("Table opened without an appropriate following space or newline")
        # [^ \n\{]\} : Table closed without space or newline
        for _ in re.finditer(r"[^ \n\{]\}", line_nc):
            context.error("Table closed without an appropriate preceding space or newline")

class ParameterPaddingVisitor(LuaStyleVisitor):
    """
    Visitor for parameter padding checks.
    Ensures at least one space after every comma in function parameters and table data, ignoring commas inside string literals.
    """
    def visit(self, line, context):
        # Remove string literals before checking for parameter padding
        line_no_strings = self.strip_strings(line)
        for _ in re.finditer(r",[^ \n]", line_no_strings):
            context.error("Multiple parameters used without an appropriate following space or newline")

class ConditionalPaddingVisitor(LuaStyleVisitor):
    """
    Visitor for conditional padding checks.
    Ensures logical operators (and/or) do not have excessive spaces around them.
    """
    def visit(self, line, context):
        code_line = line.lstrip()
        if re.search(r"\s{2,}(and|or)(\s{1,}|$)|\s{1,}(and|or)\s{2,}", code_line):
            context.error("Multiple spaces detected around logical operator.")

class SemicolonVisitor(LuaStyleVisitor):
    """
    Visitor for semicolon checks.
    Ensures no semicolons are used in Lua scripts, ignoring those inside strings.
    """
    def visit(self, line, context):
        # Ignore strings in line
        removed_quote_str = self.strip_strings(line)
        for _ in re.finditer(r";", removed_quote_str):
            context.error("Semicolon detected in line.")

class VariableNamingVisitor(LuaStyleVisitor):
    """
    Visitor for variable naming checks.
    Ensures variables do not use underscores and are lowerCamelCased, except for 'ID'.
    """
    def visit(self, line, context):
        # Capitalised local name
        for match in re.finditer(r"local (?=[^(ID)])(?=[A-Z]){1,}", line):
            context.error("Capitalised local name")
        # Underscore in variable name
        if "local " in line and " =" in line:
            var_line = line.split(" =", 1)[0]
            var_line = var_line.replace('local','').strip()
            if var_line != '':
                for part in var_line.split(','):
                    part = part.strip()
                    if len(part) > 1 and '_' in part:
                        context.error("Underscore in variable name")

class IndentationVisitor(LuaStyleVisitor):
    """
    Visitor for indentation checks.
    Ensures indentation is in multiples of four spaces.
    """
    def visit(self, line, context):
        if (len(line) - len(line.lstrip(' '))) % 4 != 0:
            context.error("Indentation must be multiples of 4 spaces")

class OperatorPaddingVisitor(LuaStyleVisitor):
    """
    Visitor for operator and comparator padding checks.
    Ensures operators/comparators have one space before and after, and no excessive padding.
    Ignores operators inside comments and string literals.
    """
    def visit(self, line, context):
        # Remove comments
        code_only = line.split('--')[0]
        # Remove string literals
        code_only = self.strip_strings(code_only)
        # Require space before and after >, <, >=, <=, ==, +, *, ~=, / operators or comparators
        for _ in re.finditer(r"[^ =~\<\>][\=\+\*\~/\><]|[\=\+\*/\><][^ =\n]", code_only):
            context.error("Operator or comparator without padding detected at end of line")
        # Ignore all content in single-line tables to allow for formatting
        stripped_line = code_only.lstrip()
        brace_regex = regex.compile(r"\{(([^\}\{]+)|(?R))*+\}", re.S)
        stripped_line = regex.sub(brace_regex, "", stripped_line)
        for _ in re.finditer(r"\s{2,}(>=|<=|==|~=|\+|\*|%|>|<|\^)|(>=|<=|==|~=|\+|\*|%|>|<|\^)\s{2,}", stripped_line):
            context.error("Excessive padding detected around operator or comparator.")

class ParenthesesPaddingVisitor(LuaStyleVisitor):
    """
    Visitor for parentheses padding checks.
    Ensures no excess whitespace inside of parentheses or solely for alignment.
    """
    def visit(self, line, context):
        line_no_strings = self.strip_strings(line)
        if len(re.findall(r"\([ ]| [\)]", line_no_strings)) > 0:
            if not line_no_strings.lstrip(' ')[0] == '(' and not line_no_strings.lstrip(' ')[0] == ')':
                context.error("No excess whitespace inside of parentheses or solely for alignment.")

class NewlineAfterEndVisitor(LuaStyleVisitor):
    """
    Visitor for newline after 'end' checks.
    Ensures an empty newline is required after 'end' if the code on the following line is at the same indentation level.
    """
    def visit(self, line, context):
        num_lines = len(context.lines)
        if context.counter < num_lines and contains_word('end')(line):
            current_indent = len(line) - len(line.lstrip(' '))
            next_indent = len(context.lines[context.counter]) - len(context.lines[context.counter].lstrip(' '))
            if current_indent == next_indent and context.lines[context.counter].strip() != "":
                context.error("Newline required after end with code following on same level")

class NoNewlineAfterFunctionDeclVisitor(LuaStyleVisitor):
    """
    Visitor for no newline after function declaration checks.
    Ensures function declarations do not have an empty newline following them.
    """
    def visit(self, line, context):
        if 'function' in line and context.counter < len(context.lines) and context.lines[context.counter].strip() == '':
            context.error("No newlines after function declaration")

class NoNewlineBeforeEndVisitor(LuaStyleVisitor):
    """
    Visitor for no newline before 'end' checks.
    Ensures 'end' does not have a newline preceding it.
    """
    def visit(self, line, context):
        if contains_word('end')(line) and context.counter > 1 and context.lines[context.counter - 2].strip() == '':
            context.error("No newlines before end statement")

class NoSingleLineFunctionVisitor(LuaStyleVisitor):
    """
    Visitor for no single line function checks.
    Ensures functions do not begin and end on a single line.
    """
    def visit(self, line, context):
        if contains_word('function')(line) and contains_word('end')(line):
            context.error("Function begins and ends on same line")

class NoSingleLineConditionVisitor(LuaStyleVisitor):
    """
    Visitor for no single line condition checks.
    Ensures conditions do not begin and end on a single line.
    """
    def visit(self, line, context):
        line_no_strings = self.strip_strings(line)
        if contains_word('if')(line_no_strings) and contains_word('end')(line_no_strings):
            context.error("Condition begins and ends on a single line")

class NoFunctionDeclPaddingVisitor(LuaStyleVisitor):
    """
    Visitor for no padding between function keyword and opening parenthesis.
    Ensures no padding occurs between function keyword and opening parenthesis.
    """
    def visit(self, line, context):
        if re.search(r"function\s+\w+\s+\(", line) or re.search(r"function\s+\(", line):
            context.error("Padding detected between function and opening parenthesis")

class MultilineConditionFormatVisitor(LuaStyleVisitor):
    """
    Visitor for multiline condition format checks.
    Ensures multi-line conditional blocks contain if/elseif and then on their own lines, with conditions indented between them.
    """
    def visit(self, line, context):
        stripped_line = re.sub(r"\".*?\"|'.*?'", "", line) # Ignore data in quotes
        if contains_word('if')(stripped_line) or contains_word('elseif')(stripped_line):
            condition_start = stripped_line.replace('elseif','').replace('if','').strip()
            if not 'then' in condition_start and condition_start != '':
                context.error("Invalid multiline conditional format")
        if contains_word('then')(stripped_line):
            condition_end = stripped_line.replace('then','').strip()
            if not 'if' in condition_end and condition_end != '':
                context.error("Invalid multiline conditional format")

class DeprecatedFunctionVisitor(LuaStyleVisitor):
    """
    Visitor for deprecated function checks.
    Ensures deprecated functions are not used and suggests replacements.
    """
    def visit(self, line, context):
        for entry in deprecated_functions:
            deprecated_func = entry[0]
            replacement = entry[1]
            if contains_word(deprecated_func)(line):
                context.error(f"Use of deprecated function: {deprecated_func}. Suggested replacement: {replacement}")

class DeprecatedRequireVisitor(LuaStyleVisitor):
    """
    Visitor for deprecated require checks.
    Ensures deprecated or unnecessary require statements are not used.
    """
    def visit(self, line, context):
        if "require(" in line:
            for deprecated_str in deprecated_requires:
                if deprecated_str in line:
                    if deprecated_str == "IDs":
                        context.error("IDs requires should be replaced with references to zones[xi.zone.ZONE_ENUM]")
                    else:
                        context.error(f"Use of deprecated/unnecessary require: {deprecated_str}. This should be removed")

class InvalidEnumVisitor(LuaStyleVisitor):
    """
    Visitor for invalid enum usage checks.
    Ensures potential invalid enum references are flagged and suggests corrections.
    """
    def visit(self, line, context):
        for invalid_enum in invalid_enums:
            if invalid_enum in line:
                context.error(f"Potential invalid enum reference used: {invalid_enum}.  Did you mean the one without an s?")

class FunctionParameterMagicNumberVisitor(LuaStyleVisitor):
    """
    Visitor for function parameter magic number checks.
    Ensures magic numbers are not used in disallowed function parameters.
    """
    def visit(self, line, context):
        for fn_name, param_locations in disallowed_numeric_parameters.items():
            regex_str = r'{0}\(([^)]+)\)'.format(fn_name)
            for parameter_str in re.findall(regex_str, line):
                parameter_list = parameter_str.split(",")
                for position in param_locations:
                    if position < len(parameter_list) and parameter_list[position].strip().isnumeric():
                        context.error(f"Magic Number is not allowed at this location ({position}).")

class MathRandomBoundsVisitor(LuaStyleVisitor):
    """
    Visitor for math.random bounds checks.
    Ensures math.random() calls have both upper and lower bounds.
    """
    def visit(self, line, context):
        randString = re.search(r'math\.random\(([^()]*)\)', line)
        if randString:
            paramList = randString.group(0).split(',')
            if len(paramList) != 2:
                context.error(f"math.random() calls should have upper and lower bounds ({randString.group(0)}).")

class GetPoolMagicNumberVisitor(LuaStyleVisitor):
    """
    Visitor for :getPool() magic number comparison checks.
    Ensures :getPool() is not compared to integer literals using conditional operators.
    """
    def visit(self, line, context):
        match = re.search(r":getPool\(\)\s*(==|~=|<=|>=|<|>)\s*\d+", line)
        if match:
            context.error(":getPool() compared to integer literal (magic number) using a conditional operator is not allowed.")

class CodeAfterThenVisitor(LuaStyleVisitor):
    """
    Visitor for detecting code after 'then' in a conditional statement on the same line.
    This is not allowed for multiline conditions and should trigger an error.
    """
    def visit(self, line, context):
        line_ncns = context.line_no_comments_or_strings
        match = re.search(r"\bthen\b\s*[^\s]", line_ncns)
        if match:
            context.error("Code after a condition ends should be on its own line.")

class CommentBlockLengthVisitor(LuaStyleVisitor):
    """
    Visitor for comment block length checks.
    Flags comment blocks of dashes not 35 characters long.
    """
    def visit(self, line, context):
        comment_header = line.rstrip("\n")
        if re.search(r"^-+$", comment_header) and len(comment_header) > 2 and len(comment_header) != 35:
            context.error("Standard comment block lines of '-' should be 35 characters.")

class StringQuoteVisitor(LuaStyleVisitor):
    """
    Visitor for string quote checks.
    Flags double-quoted strings, expects single quotes for string literals.
    """
    def visit(self, line, context):
        code_line = line.split('--')[0]
        # Corrected regex: match double-quoted strings not inside single quotes
        if re.search(r'"([^"\\]|\\.)*"', code_line):
            context.error("Strings should only be contained by single quotes")

class LogicalOperatorLineVisitor(LuaStyleVisitor):
    """
    Visitor for lines starting with 'and'/'or' or ending with 'not'.
    Flags these anywhere, not just in conditions.
    """
    def visit(self, line, context):
        line_nc = context.line_no_comments
        stripped_line = line_nc.strip()
        if stripped_line.startswith('and ') or stripped_line.startswith('or '):
            context.error('Multiline conditions should not start with and|or')
        if stripped_line.endswith('not'):
            context.error('Multiline conditions should not end with not')

class LuaStyleCheck:
    def __init__(self, input_file, show_errors=True):
        self.context = LuaStyleContext(input_file, show_errors)
        self.run_style_check()

    def error(self, error_string, suppress_line_ref = False):
        self.context.error(error_string, suppress_line_ref)

    def run_style_check(self):
        if self.context.filename is None:
            print("ERROR: No filename provided to LuaStyleCheck class.")
            return
        with open(self.context.filename, 'r') as f:
            self.context.lines = f.readlines()
            visitors = [
                CommentBlockLengthVisitor(),
                StringQuoteVisitor(),
                LogicalOperatorLineVisitor(),
                RewardTableVisitor(),
                TableFormattingVisitor(),
                ParameterPaddingVisitor(),
                ConditionalPaddingVisitor(),
                SemicolonVisitor(),
                VariableNamingVisitor(),
                IndentationVisitor(),
                OperatorPaddingVisitor(),
                ParenthesesPaddingVisitor(),
                NewlineAfterEndVisitor(),
                NoNewlineAfterFunctionDeclVisitor(),
                NoNewlineBeforeEndVisitor(),
                NoSingleLineFunctionVisitor(),
                NoSingleLineConditionVisitor(),
                NoFunctionDeclPaddingVisitor(),
                MultilineConditionFormatVisitor(),
                DeprecatedFunctionVisitor(),
                DeprecatedRequireVisitor(),
                InvalidEnumVisitor(),
                FunctionParameterMagicNumberVisitor(),
                MathRandomBoundsVisitor(),
                GetPoolMagicNumberVisitor(),
                CodeAfterThenVisitor(),
            ]
            conditional_visitor = ConditionalFormattingVisitor()
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
                code_line_no_comments = line.split('--')[0].strip()
                if self.context.in_condition:
                    self.context.full_condition += code_line_no_comments + '\n'
                    if re.search(r"\bthen\b", code_line_no_comments):
                        # End of condition block, check it
                        conditional_visitor.visit(self.context.full_condition, self.context)
                        self.context.in_condition = False
                        self.context.full_condition = ""
                elif re.search(r'\b(if|elseif)\b', code_line_no_comments):
                    self.context.in_condition = True
                    self.context.full_condition = code_line_no_comments + '\n'
                    # Single-line condition
                    if re.search(r'\bthen\b', code_line_no_comments):
                        conditional_visitor.visit(self.context.full_condition, self.context)
                        self.context.in_condition = False
                        self.context.full_condition = ""
                # Always run all other visitors
                for visitor in visitors:
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
