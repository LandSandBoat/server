#!/bin/bash

# Requires the following packages:
# Package manager: luarocks
# luarocks install luacheck --local
# luarocks install lanes --local

target=${1:-scripts}

global_funcs=`python3 << EOF
import re
file = open('src/map/lua/luautils.cpp', 'r')
data = file.read()
file.close()
# Find all bound global functions
matches = re.findall(r'(?<=set_function\(\")(.*)(?=\",)', data)
# Make sure they're capitalized
matches = map(lambda s: s[:1].upper() + s[1:] if s else '', matches)
# Print space-delimited for piping back to bash
print(*matches)
EOF`

global_objects=(
    xi
    ai
    os
    _

    Module
    Override
    super
    applyOverride

    common
    zones
    quests
    utils
    npcUtil

    mixins
    g_mixins
    applyMixins

    set
    printf
    switch
    clearVarFromAll
    getVanaMidnight
    getMidnight
    getConquestTally
    vanaDay

    mission
    Mission
    quest
    Quest
    HiddenQuest
    fileExists
    InteractionGlobal
    InteractionLookup
    Action
    actionUtil
    interactionUtil
    KeyItemAction
    LambdaAction
    Message
    NoAction
    Sequence
    Container
    Event
    Battlefield
    BattlefieldMission
    BattlefieldQuest
    Limbus

    removeSleepEffects

    QUEST_AVAILABLE
    QUEST_ACCEPTED
    QUEST_COMPLETED

    onBattlefieldHandlerInitialise

    getRecommendedAssaultLevel

    PATHFLAG_WALLHACK

    RoeParseTimed
    getRoeRecords
    RoeParseRecords

    cmdprops
    error
    onTrigger

    SetExplorerMoogles

    applyHalloweenNpcCostumes
    isHalloweenEnabled
    onHalloweenTrade
    HALLOWEEN_2008
    HALLOWEEN_2009
    HALLOWEEN_2010

    salvageUtil

    getFlourishAnimation
    getStepAnimation
    hasSleepEffects
    skillchainCount
    takeAbilityDamage

    doAutoRangedWeaponskill
    doAutoPhysicalWeaponskill

    AbilityFinalAdjustments

    MOBSKILL_MAGICAL
    MOBSKILL_PHYSICAL

    TPMOD_NONE
    TPMOD_CHANCE
    TPMOD_CRITICAL
    TPMOD_DAMAGE
    TPMOD_ACC
    TPMOD_ATTACK
    TPMOD_DURATION
    SC_NONE
    SC_IMPACTION
    SC_TRANSFIXION
    SC_DETONATION
    SC_REVERBERATION
    SC_SCISSION
    SC_INDURATION
    SC_LIQUEFACTION
    SC_COMPRESSION
    SC_FUSION
    SC_FRAGMENTATION
    SC_DISTORTION
    SC_GRAVITATION
    SC_DARKNESS
    SC_LIGHT
    SC_LIGHT_II
    SC_DARKNESS_II
    INT_BASED
    CHR_BASED
    MND_BASED
    BluePhysicalSpell
    BlueMagicalSpell
    BlueFinalAdjustments
    getBlueEffectDuration

    LEUJAOAM_ASSAULT_POINT
    MAMOOL_ASSAULT_POINT
    LEBROS_ASSAULT_POINT
    PERIQIA_ASSAULT_POINT
    ILRUSI_ASSAULT_POINT
    NYZUL_ISLE_ASSAULT_POINT

    ForceCrash
    BuildString

    DYNAMIC_LOOKUP
)

ignores=(
    "unused variable ID"
)

ignore_rules=(
    311 # value assigned to variable <> is unused
    542 # empty if branch
)

~/.luarocks/bin/luacheck ${target} \
--quiet --jobs 4 --no-config --codes \
--no-unused-args \
--no-max-line-length \
--max-cyclomatic-complexity 30 \
--globals ${global_funcs[@]} ${global_objects[@]} \
--ignore ${ignores[@]} ${ignore_rules[@]} | grep -v "Total:"

python3 << EOF
import glob
import re

def contains_word(word):
    return re.compile(r'\b({0})\b'.format(word)).search

def check_for_underscores(str):
    if "local " in str and " =" in str:
        str = str.split(" =", 1)[0]
        result = re.search("local (.*) =", str)
        if result:
            str = result.group(1)
            str = str.strip()
            for part in str.split(','):
                part = part.strip()
                if len(part) > 1 and '_' in part:
                    return True
    return False

def check_tables_in_file(name):
    errcount = 0
    with open(name, 'r+') as f:
        counter = 0
        lines = f.readlines()
        in_block_comment = False
        for line in lines:
            counter = counter + 1

            if "--[[" in line:
                in_block_comment = True

            if "]]--" in line:
                in_block_comment = False

            if in_block_comment:
                continue

            # [ ]{0,} : Any number of spaces
            # =       : = character
            # [ ]{0,} : Any number of spaces
            # \{      : { character
            # [ ]{0,} : Any number of spaces
            # \n      : newline character

            for match in re.finditer("[ ]{0,}=[ ]{0,}\{[ ]{0,}\n", line):
                print(f"Incorrectly defined table: {name}:{counter}:{match.start() + 2}")
                print("")
                print(lines[counter - 2].strip())
                print(f"{lines[counter - 1].strip()}                              <-- HERE")
                print(lines[counter].strip())
                print("")

            # local     : 'local ' (with a space)
            # (?=       : Positive lookahead
            # [^(ID)])  : A token that is NOT 'ID'
            # (?=[A-Z]) : A token that starts with a capital letter

            for match in re.finditer("local (?=[^(ID)])(?=[A-Z]){1,}", line):
                print(f"Capitalised local name: {name}:{counter}:{match.start() + 2}")
                print("")
                print(lines[counter - 2].strip())
                print(f"{lines[counter - 1].strip()}                              <-- HERE")
                print(lines[counter].strip())
                print("")

            # \{         : Opening curly brace
            # [^ ^\n^\}] : Match single characters in list: NOT space or NOT newline or NOT closing curly brace

            for match in re.finditer("\{[^ ^\n^\}]", line):
                print(f"Table opened without an appropriate following space or newline: {name}:{counter}:{match.start() + 2}")
                print(f"{lines[counter - 1].strip()}                              <-- HERE")
                print("")
                errcount += 1

            # [^ ^\n^\{] : Match single characters in list: NOT space or NOT newline or NOT opening curly brace
            # \}         : Closing curly brace

            for match in re.finditer("[^ ^\n^\{]\}", line):
                print(f"Table closed without an appropriate preceding space or newline: {name}:{counter}:{match.start() + 2}")
                print(f"{lines[counter - 1].strip()}                              <-- HERE")
                print("")
                errcount += 1

            # local : 'local ' (with a space)
            # .*    : Any number of any character
            # _     : Underscore
            # .*    : Any number of any character
            #  =    : ' =' (variable assignment)
            if check_for_underscores(line):
                print(f"Underscore in variable name: {name}:{counter}")
                print(f"{lines[counter - 1].strip()}                              <-- HERE")
                print("")
                errcount += 1

            # ,[^ \n] : Any comma that does not have space or newline following
            for match in re.finditer(",[^ \n]", line):
                print(f"Multiple parameters used without an appropriate following space or newline: {name}:{counter}:{match.start() + 2}")
                print(f"{lines[counter - 1].strip()}                              <-- HERE")
                print("")
                errcount += 1

            # .*\;$ : Any line that ends with a semi-colon (TODO: No semicolons outside of comments at all)
            for match in re.finditer(".*\;$", line):
                print(f"Semicolon detected at end of line: {name}:{counter}:{match.start() + 2}")
                print(f"{lines[counter - 1].strip()}                              <-- HERE")
                print("")
                errcount += 1

            # [^ =~\<\>][\=\+\*\~\/]|[\=\+\*\/][^ =\n] : Require space before and after >, <, >=, <=, ==, +, *, ~=, / operators or comparators
            stripped_line = re.sub("--.*?(\r\n?|\n)", "", line)        # Strip to end of line if it begins with '--'
            stripped_line = re.sub("\".*?\"|'.*?'", "", stripped_line) # Ignore data in quotes
            for match in re.finditer("[^ =~\<\>][\=\+\*\~\/]|[\=\+\*\/][^ =\n]", stripped_line):
                print(f"Operator or comparator without padding detected at end of line: {name}:{counter}:{match.start() + 2}")
                print(f"{lines[counter - 1].strip()}                              <-- HERE")
                print("")
                errcount += 1

            # Multiline conditionals should not have data in if, elseif, or then
            stripped_line = re.sub("--.*?(\r\n?|\n)", "", line)        # Strip to end of line if it begins with '--'
            stripped_line = re.sub("\".*?\"|'.*?'", "", stripped_line) # Ignore data in quotes
            if contains_word('if')(stripped_line) or contains_word('elseif')(stripped_line):
                condition_start = stripped_line.replace('elseif','').replace('if','').strip()
                if not 'then' in condition_start and condition_start != '':
                    print(f"Invalid multiline conditional format: {name}:{counter}")
                    print(f"{lines[counter - 1].strip()}                              <-- HERE")
                    print("")
                    errcount += 1

            if contains_word('then')(stripped_line):
                condition_end = stripped_line.replace('then','').strip()
                if not 'if' in condition_end and condition_end != '':
                    print(f"Invalid multiline conditional format: {name}:{counter}")
                    print(f"{lines[counter - 1].strip()}                              <-- HERE")
                    print("")
                    errcount += 1

        # If you want to modify the files during the checks, write your changed lines to the appropriate
        # place in 'lines' (usually with 'lines[counter - 1]') and uncomment these two lines.
        #
        # f.seek(0)
        # f.writelines(lines)

        return errcount

target = '${target}'

totalErrors = 0
if target == 'scripts':
    for filename in glob.iglob('scripts/**/*.lua', recursive=True):
        totalErrors += check_tables_in_file(filename)
else:
    check_tables_in_file(target)

if totalErrors > 0:
    print("Lua styling errors: " + str(totalErrors))
EOF
