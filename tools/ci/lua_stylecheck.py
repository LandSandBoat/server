import glob
import re
import regex
import sys

# Global Variables
# TODO: Make this more elegant, but allow not having to pass this between all functions
lines        = []
counter      = 0
filename     = ""
total_errors = 0
errcount     = 0

def contains_word(word):
    return re.compile(r'\b({0})\b'.format(word)).search

def show_error(error_string):
    global lines
    global counter
    global filename
    global errcount

    print(f"{error_string}: {filename}:{counter}")
    print("")
    print(f"{lines[counter - 1].strip()}                              <-- HERE")
    print("")

    errcount += 1

def check_table_formatting(line):
    # [ ]{0,} : Any number of spaces
    # =       : = character
    # [ ]{0,} : Any number of spaces
    # \{      : { character
    # [ ]{0,} : Any number of spaces
    # \n      : newline character

    for _ in re.finditer("[ ]{0,}=[ ]{0,}\{[ ]{0,}\n", line):
        show_error("Incorrectly defined table")

    # \{         : Opening curly brace
    # [^ ^\n^\}] : Match single characters in list: NOT space or NOT newline or NOT closing curly brace

    for _ in re.finditer("\{[^ ^\n^\}]", line):
        show_error("Table opened without an appropriate following space or newline")

    # [^ ^\n^\{] : Match single characters in list: NOT space or NOT newline or NOT opening curly brace
    # \}         : Closing curly brace

    for _ in re.finditer("[^ ^\n^\{]\}", line):
        show_error("Table closed without an appropriate preceding space or newline")

def check_parameter_padding(line):
    # ,[^ \n] : Any comma that does not have space or newline following

    for _ in re.finditer(",[^ \n]", line):
        show_error("Multiple parameters used without an appropriate following space or newline")

def check_semicolon(line):
    # .*\;$ : Any line that ends with a semi-colon (TODO: No semicolons outside of comments at all)

    for _ in re.finditer(".*\;$", line):
        show_error("Semicolon detected at end of line")

def check_variable_names(line):
    # local     : 'local ' (with a space)
    # (?=       : Positive lookahead
    # [^(ID)])  : A token that is NOT 'ID'
    # (?=[A-Z]) : A token that starts with a capital letter

    for match in re.finditer("local (?=[^(ID)])(?=[A-Z]){1,}", line):
        show_error("Capitalised local name")

    # local : 'local ' (with a space)
    # .*    : Any number of any character
    # _     : Underscore
    # .*    : Any number of any character
    #  =    : ' =' (variable assignment)

    if "local " in line and " =" in line:
        line = line.split(" =", 1)[0]
        result = re.search("local (.*) =", line)
        if result:
            line = result.group(1)
            line = line.strip()
            for part in line.split(','):
                part = part.strip()
                if len(part) > 1 and '_' in part:
                    show_error("Underscore in variable name")

# Require four-space intervals for indents
def check_indentation(line):
    if (len(line) - len(line.lstrip(' '))) % 4 != 0:
        show_error("Indentation must be multiples of 4 spaces")

def check_operator_padding(line):
    # [^ =~\<\>][\=\+\*\~\/\>\<]|[\=\+\*\/\>\<][^ =\n] : Require space before and after >, <, >=, <=, ==, +, *, ~=, / operators or comparators

    stripped_line = re.sub("\".*?\"|'.*?'", "", line) # Ignore data in quotes
    for _ in re.finditer("[^ =~\<\>][\=\+\*\~\/\>\<]|[\=\+\*\/\>\<][^ =\n]", stripped_line):
        show_error("Operator or comparator without padding detected at end of line")

def check_multiline_condition_format(line):
    stripped_line = re.sub("\".*?\"|'.*?'", "", line) # Ignore data in quotes
    if contains_word('if')(stripped_line) or contains_word('elseif')(stripped_line):
        condition_start = stripped_line.replace('elseif','').replace('if','').strip()
        if not 'then' in condition_start and condition_start != '':
            show_error("Invalid multiline conditional format")

    if contains_word('then')(stripped_line):
        condition_end = stripped_line.replace('then','').strip()
        if not 'if' in condition_end and condition_end != '':
            show_error("Invalid multiline conditional format")

### TODO:
# No empty newline after function declarations
# No empty newline before end
# If condition has == QUEST_COMPLETED, prefer hasCompletedQuest
# If contains trade:getItemCount, prefer npcUtil function
# No useless parens (paren without and|or in entire section)
# Parentheses must have and|or in conditions
# Only 1 space before and after comparators
# No whitespace after opening paren
# No empty in-line comments

def run_style_check():
    global counter
    global lines
    global errcount

    errcount = 0
    with open(filename, 'r') as f:
        counter          = 0
        lines            = f.readlines()
        in_block_comment = False

        for line in lines:
            counter = counter + 1

            # Ignore Block Comments
            if "--[[" in line:
                in_block_comment = True

            if "]]" in line:
                in_block_comment = False

            if in_block_comment:
                continue

            # Remove in-line comments
            code_line = re.sub("--.*?(\r\n?|\n)", "", line)

            # Checks that apply to all lines
            check_table_formatting(code_line)
            check_parameter_padding(code_line)
            check_variable_names(code_line)
            check_semicolon(code_line)
            # check_indentation(code_line)
            check_operator_padding(code_line)

            # Multiline conditionals should not have data in if, elseif, or then
            check_multiline_condition_format(code_line)

            # Condition blocks/lines should not have outer parentheses
            # Find all strings contained in parentheses: \((([^\)\(]+)|(?R))*+\)
            # If nothing is left on the line after removing, then the string breaks rules
            # TODO: If we have a string inside parentheses, make sure it has and/or in the string

            if contains_word('if')(code_line) or contains_word('elseif')(code_line):
                # Single line conditions
                if contains_word('then')(code_line):
                    condition_str = code_line.replace('elseif','').replace('if','').replace('then','').strip()
                    paren_regex = regex.compile("\((([^\)\(]+)|(?R))*+\)", re.S)
                    removed_paren_str = regex.sub(paren_regex, "", condition_str)

                    if removed_paren_str == "":
                        print(f"Outer parentheses should be removed in condition: {filename}:{counter}")
                        print(f"{lines[counter - 1].strip()}                              <-- HERE")
                        print("")
                        errcount += 1

                    #if len(re.findall("and|or", condition_str)) > 0 and len(condition_str) > 40:
                    #    print(f"Multiline conditional format required: {filename}:{counter}")
                    #    print(f"{lines[counter - 1].strip()}                              <-- HERE")
                    #    print("")
                    #    errcount += 1

                    if len(re.findall("== true|== false|~= true|~= false", condition_str)) > 0:
                        print(f"Boolean with explicit value check: {filename}:{counter}")
                        print(f"{lines[counter - 1].strip()}                              <-- HERE")
                        print("")
                        errcount += 1

        # If you want to modify the files during the checks, write your changed lines to the appropriate
        # place in 'lines' (usually with 'lines[counter - 1]') and uncomment these two lines.
        #
        # f.seek(0)
        # f.writelines(lines)

        return errcount

target = sys.argv[1]

total_errors = 0
if target == 'scripts':
    for filename in glob.iglob('scripts/**/*.lua', recursive = True):
        total_errors += run_style_check()
else:
    run_style_check(target)

if total_errors > 0:
    print("Lua styling errors: " + str(total_errors))
