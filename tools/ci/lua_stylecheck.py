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
]

deprecated_requires = [
    "scripts/globals/keyitems",
    "scripts/globals/loot",
    "scripts/globals/status",
    "scripts/globals/settings",
    "scripts/enum",
]

def contains_word(word):
    return re.compile(r'\b({0})\b'.format(word)).search

class LuaStyleCheck:
    def __init__(self, input_file, show_errors = True):
        self.filename = input_file
        self.show_errors = show_errors

        self.run_style_check()

    def error(self, error_string):
        """Displays error_string along with filename and line.  Increments errcount for the class."""

        if self.show_errors:
            print(f"{error_string}: {self.filename}:{self.counter}")
            print(f"{self.lines[self.counter - 1].strip()}                              <-- HERE")
            print("")

        self.errcount += 1

    def check_table_formatting(self, line):
        """Check for proper table styling:
        Multi-line tables should use Allman braces, and all braces should be have at least one space or newline
        prior to any nested table definition.

        See: https://github.com/LandSandBoat/server/wiki/Development-Guide-Lua#allman-braces
        """
        # [ ]{0,} : Any number of spaces
        # =       : = character
        # [ ]{0,} : Any number of spaces
        # \{      : { character
        # [ ]{0,} : Any number of spaces
        # \n      : newline character

        for _ in re.finditer("[ ]{0,}=[ ]{0,}\{[ ]{0,}\n", line):
            self.error("Incorrectly defined table")

        # \{         : Opening curly brace
        # [^ \n\}] : Match single characters in list: NOT space or NOT newline or NOT closing curly brace

        for _ in re.finditer("\{[^ \n\}]", line):
            self.error("Table opened without an appropriate following space or newline")

        # [^ \n\{] : Match single characters in list: NOT space or NOT newline or NOT opening curly brace
        # \}         : Closing curly brace

        for _ in re.finditer("[^ \n\{]\}", line):
            self.error("Table closed without an appropriate preceding space or newline")

    def check_parameter_padding(self, line):
        """Require padding between all parameters
        All function parameters and tabled data should contain at least one space following every
        comma.

        See: TBD
        """
        # ,[^ \n] : Any comma that does not have space or newline following

        for _ in re.finditer(",[^ \n]", line):
            self.error("Multiple parameters used without an appropriate following space or newline")

    def check_semicolon(self, line):
        """No semi-colons should be used in Lua scripts.

        See: https://github.com/LandSandBoat/server/wiki/Development-Guide-Lua#no-semicolons
        """

        # Ignore strings in line
        quote_regex = regex.compile("\"(([^\"\"]+)|(?R))*+\"|\'(([^\'\']+)|(?R))*+\'", re.S)
        removed_quote_str = regex.sub(quote_regex, "", line)

        # ; : Any line that contains a semicolon.

        for _ in re.finditer(";", removed_quote_str):
            self.error("Semicolon detected in line.")

    def check_variable_names(self, line):
        """Variables should not use underscores and be lowerCamelCased with the exception of `ID`

        See: https://github.com/LandSandBoat/server/wiki/Development-Guide-Lua#naming-and-misc
        """
        # local     : 'local ' (with a space)
        # (?=       : Positive lookahead
        # [^(ID)])  : A token that is NOT 'ID'
        # (?=[A-Z]) : A token that starts with a capital letter

        for match in re.finditer("local (?=[^(ID)])(?=[A-Z]){1,}", line):
            self.error("Capitalised local name")

        if "local " in line and " =" in line:
            line = line.split(" =", 1)[0]
            line = line.replace('local','').strip()
            if line != '':
                for part in line.split(','):
                    part = part.strip()
                    if len(part) > 1 and '_' in part:
                        self.error("Underscore in variable name")

    def check_indentation(self, line):
        """Indentation should be multiples of four spaces.

        See: TBD
        """
        if (len(line) - len(line.lstrip(' '))) % 4 != 0:
            self.error("Indentation must be multiples of 4 spaces")

    def check_operator_padding(self, line):
        """All operators and comparators (>, <, >=, <=, ==, +, *, ~=, /, etc) should contain one space before and
        after their usage.

        See: TBD
        """
        # [^ =~\<\>][\=\+\*\~\/\>\<]|[\=\+\*\/\>\<][^ =\n] : Require space before and after >, <, >=, <=, ==, +, *, ~=, / operators or comparators

        stripped_line = re.sub("\".*?\"|'.*?'", "", line) # Ignore data in quotes
        for _ in re.finditer("[^ =~\<\>][\=\+\*\~\/\>\<]|[\=\+\*\/\>\<][^ =\n]", stripped_line):
            self.error("Operator or comparator without padding detected at end of line")

    def check_parentheses_padding(self, line):
        """Parentheses should have padding prior to opening and after closing, but must not contain padding after
        the open parenthesis, or prior to closing.

        See: https://github.com/LandSandBoat/server/wiki/Development-Guide-Lua#no-excess-whitespace-inside-of-parentheses-or-solely-for-alignment
        """

        if len(re.findall("\([ ]| [\)]", line)) > 0:
            if not line.lstrip(' ')[0] == '(' and not line.lstrip(' ')[0] == ')': # Ignore large blocks ending or opening
                self.error("No excess whitespace inside of parentheses or solely for alignment.")

    def check_newline_after_end(self, line):
        """An empty newline is required after end if the code on the following line is at the same indentation level.

        See: TBD
        """
        num_lines = len(self.lines)

        if self.counter < num_lines and contains_word('end')(line):
            current_indent = len(line) - len(line.lstrip(' '))
            next_indent    = len(self.lines[self.counter]) - len(self.lines[self.counter].lstrip(' '))

            if current_indent == next_indent and self.lines[self.counter].strip() != "":
                self.error("Newline required after end with code following on same level")

    def check_no_newline_after_function_decl(self, line):
        """Function declarations should not have an empty newline following them.

        See: TBD
        """

        if 'function' in line and self.lines[self.counter].strip() == '':
            self.error("No newlines after function declaration")

    def check_no_newline_before_end(self, line):
        """`end` should not have a newline preceding it.

        See: TBD
        """

        if contains_word('end')(line) and self.lines[self.counter - 2].strip() == '':
            self.error("No newlines before end statement")

    def check_no_single_line_functions(self, line):
        """Functions should not begin and end on a single line.

        See: TBD
        """

        if contains_word('function')(line) and contains_word('end')(line):
            self.error("Function begins and ends on same line")

    def check_no_single_line_conditions(self, line):
        """Conditions should not begin and end on a single line.

        See: TBD
        """

        if contains_word('if')(line) and contains_word('end')(line):
            self.error("Condition begins and ends on a single line")

    def check_no_function_decl_padding(self, line):
        """No padding should occur between function keyword and opening parenthesis.

        See: TBD
        """

        if re.search("function\s{1,}\(", line):
            self.error("Padding detected between function and opening parenthesis")

    def check_multiline_condition_format(self, line):
        """Multi-line conditional blocks should contain if/elseif and then on their own lines,
        with conditions indented between them.

        See: https://github.com/LandSandBoat/server/wiki/Development-Guide-Lua#formatting-conditional-blocks
        """

        stripped_line = re.sub("\".*?\"|'.*?'", "", line) # Ignore data in quotes
        if contains_word('if')(stripped_line) or contains_word('elseif')(stripped_line):
            condition_start = stripped_line.replace('elseif','').replace('if','').strip()
            if not 'then' in condition_start and condition_start != '':
                self.error("Invalid multiline conditional format")

        if contains_word('then')(stripped_line):
            condition_end = stripped_line.replace('then','').strip()
            if not 'if' in condition_end and condition_end != '':
                self.error("Invalid multiline conditional format")

    def check_deprecated_functions(self, line):
        for entry in deprecated_functions:
            deprecated_func = entry[0]
            replacement     = entry[1]
            if contains_word(deprecated_func)(line):
                self.error(f"Use of deprecated function: {deprecated_func}. Suggested replacement: {replacement}")

    def check_deprecated_require(self, line):
        if ("require(") in line:
            for deprecated_str in deprecated_requires:
                if deprecated_str in line:
                    self.error(f"Use of deprecated/unnecessary require: {deprecated_str}. This should be removed")

    def run_style_check(self):
        if self.filename is None:
            print("ERROR: No filename provided to LuaStyleCheck class.")
            return

        with open(self.filename, 'r') as f:
            self.lines          = f.readlines()
            in_block_comment    = False
            in_condition        = False
            full_condition      = ""

            for line in self.lines:
                self.counter = self.counter + 1

                # Ignore Block Comments
                if "--[[" in line:
                    in_block_comment = True

                if "]]" in line:
                    in_block_comment = False

                if in_block_comment:
                    continue

                # Remove in-line comments
                code_line = re.sub("(?=--)(.*?)(?=\r\n|\n)", "", line)

                # Checks that apply to all lines
                self.check_table_formatting(code_line)
                self.check_parameter_padding(code_line)
                self.check_variable_names(code_line)
                self.check_semicolon(code_line)
                self.check_indentation(code_line)
                self.check_operator_padding(code_line)
                self.check_parentheses_padding(code_line)
                self.check_no_single_line_functions(code_line)
                self.check_no_single_line_conditions(code_line)
                self.check_newline_after_end(code_line)
                self.check_no_newline_after_function_decl(code_line)
                self.check_no_newline_before_end(code_line)
                self.check_no_function_decl_padding(code_line)
                self.check_deprecated_require(code_line)

                # Multiline conditionals should not have data in if, elseif, or then
                self.check_multiline_condition_format(code_line)

                self.check_deprecated_functions(code_line)

                # Condition blocks/lines should not have outer parentheses
                # Find all strings contained in parentheses: \((([^\)\(]+)|(?R))*+\)
                # If nothing is left on the line after removing, then the string breaks rules
                # TODO: If we have a string inside parentheses, make sure it has and/or in the string

                if contains_word('if')(code_line) or contains_word('elseif')(code_line) or in_condition:
                    full_condition += code_line

                    if contains_word('then')(code_line):
                        condition_str = full_condition.replace('elseif','').replace('if','').replace('then','').strip()
                        paren_regex = regex.compile("\((([^\)\(]+)|(?R))*+\)", re.S)
                        removed_paren_str = regex.sub(paren_regex, "", condition_str)

                        if removed_paren_str == "":
                            self.error("Outer parentheses should be removed in condition")

                        if len(re.findall("== true|== false|~= true|~= false", condition_str)) > 0:
                            self.error("Boolean with explicit value check")

                        if not in_condition and len(re.findall(" and | or ", condition_str)) > 0 and len(condition_str) > 72:
                            self.error("Multiline conditional format required")

                        in_condition   = False
                        full_condition = ""

                    # Multiline conditions
                    else:
                        in_condition = True

                    # Do single line rules for condition here, space in string check is intentional to allow
                    # and|or on its own line in some cases.
                    stripped_line = code_line.strip()
                    if stripped_line.startswith('and ') or stripped_line.startswith('or '):
                        self.error('Multiline conditions should not start with and|or')

                    if stripped_line.endswith('not'):
                        self.error('Multiline conditions should not end with not')
                

            # If you want to modify the files during the checks, write your changed lines to the appropriate
            # place in 'lines' (usually with 'lines[counter - 1]') and uncomment these two lines.
            #
            # f.seek(0)
            # f.writelines(lines)

        return

    show_errors  = True
    lines        = []
    counter      = 0
    filename     = ""
    errcount     = 0


### TODO:
# No useless parens (paren without and|or in entire section)
# Parentheses must have and|or in conditions
# Only 1 space before and after comparators
# No empty in-line comments

target = sys.argv[1]

total_errors    = 0
expected_errors = 0

if target == 'scripts':
    for filename in glob.iglob('scripts/**/*.lua', recursive = True):
        total_errors += LuaStyleCheck(filename).errcount
elif target == 'test':
    total_errors = LuaStyleCheck('tools/ci/tests/stylecheck.lua', show_errors = False).errcount
    expected_errors = 41
else:
    total_errors = LuaStyleCheck(target).errcount

if total_errors != expected_errors:
    if target != 'test':
        print(f"Lua styling errors: {total_errors}")
    else:
        print(f"Stylecheck Unit tests failed! Expected {expected_errors} errors and found {total_errors}.")
