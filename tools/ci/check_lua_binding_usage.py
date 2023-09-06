#!/usr/bin/python
#
# Run from repo root!

import glob
import os
import re

function_names = []


def extract_function_names():
    for filename in os.listdir("src/map/lua/"):
        full_filename = os.path.join("src/map/lua/", filename)
        if os.path.isfile(full_filename):
            with open(full_filename, mode="r", encoding="utf-8") as file:
                for line in file.readlines():
                    if 'SOL_REGISTER("' in line:
                        function_names.append(line.strip().split('"')[1])


def main():
    extract_function_names()

    # Add Lua exceptions
    function_names.append("format")
    function_names.append("caseof")
    function_names.append("gsub")

    function_names.append("skip_to_next")

    # Add exceptions for interaction, battle frameworks, and other user Lua types
    function_names.append("new")
    function_names.append("event")
    function_names.append("begin")
    function_names.append("progress")
    function_names.append("cutscene")
    function_names.append("progressEvent")
    function_names.append("progressCutscene")
    function_names.append("importantOnce")
    function_names.append("perform")
    function_names.append("addNext")
    function_names.append("getCheckArgs")
    function_names.append("setPriority")
    function_names.append("message")
    function_names.append("keyItem")
    function_names.append("setMustZone")
    function_names.append("getMustZone")
    function_names.append("setTimedVar")
    function_names.append("setVarExpiration")
    function_names.append("oncePerZone")
    function_names.append("incrementVar")
    function_names.append("replaceDefault")
    function_names.append("addContainers")
    function_names.append("addDefaultHandlers")
    function_names.append("afterZoneIn")
    function_names.append("onTrigger")
    function_names.append("onTrade")
    function_names.append("onMobDeath")
    function_names.append("onZoneIn")
    function_names.append("noAction")
    function_names.append("onZoneOut")
    function_names.append("onTriggerAreaEnter")
    function_names.append("onTriggerAreaLeave")
    function_names.append("onEventFinish")
    function_names.append("onEventUpdate")
    function_names.append("sequence")
    function_names.append("setVarBit")
    function_names.append("isVarBitsSet")
    function_names.append("importantEvent")
    function_names.append("replaceEvent")
    function_names.append("removeContainer")
    function_names.append("addContainer")
    function_names.append("isValidEntry")
    function_names.append("checkRequirements")
    function_names.append("onEntryEventUpdate")
    function_names.append("checkSkipCutscene")
    function_names.append("replaceEvent")
    function_names.append("onBattlefieldWin")
    function_names.append("onBattlefieldLoss")
    function_names.append("onBattlefieldWipe")
    function_names.append("handleWipe")
    function_names.append("unsetVarBit")
    function_names.append("addVar")
    function_names.append("getLocaLVar")
    function_names.append("register")
    function_names.append("addEssentialMobs")
    function_names.append("handleLootRolls")
    function_names.append("extendTimeLimit")
    function_names.append("closeDoors")
    function_names.append("check")
    function_names.append("face")
    function_names.append("startFunc")
    function_names.append("enableCheck")
    function_names.append("endFunc")
    function_names.append("checkEnding")
    function_names.append("checkStarting")
    function_names.append("setEnableCheck")
    function_names.append("setStartFunction")
    function_names.append("setEndFunction")

    # root_dir needs a trailing slash (i.e. /root/dir/)
    for filename in glob.iglob("./scripts/" + "**/*.lua", recursive=True):
        if os.path.isfile(filename):
            with open(filename, mode="r", encoding="utf-8") as file:
                in_block_comment = False
                counter = 0
                for line in file.readlines():
                    counter = counter + 1

                    if "--[[" in line:
                        in_block_comment = True

                    if "]]--" in line:
                        in_block_comment = False

                    if in_block_comment:
                        continue

                    # Try and ignore comments
                    line = line.split("--", 1)[0]

                    # Don't look inside strings (replace with placeholder)
                    line = re.sub('\"([^\"]*?)\"', "strVal", line)
                    line = re.sub("\'([^\"]*?)\'", "strVal", line)

                    # Try and ignore function definitions
                    line = line.split("function", 1)[0]

                    line = line.replace("\n", "")

                    for match in re.finditer('(?<=:)[^\(\/\\\: "]*', line):
                        if (
                            len(match.group()) > 1
                            and match.group() not in function_names
                        ):
                            filename = filename.replace("\\", "/")
                            print(
                                f"Could not find function match for {match.group()} ({filename}:{counter}:{match.start() + 1})"
                            )


if __name__ == "__main__":
    main()
