#!/bin/bash
# Requires the following packages:
# Package manager: luarocks
# luarocks install luacheck --local
# luarocks install lanes --local

target=${1:-scripts}
printf "Target: %s\n" ${target}

printf "Gathering information on settings\n"
settings_names=`python3 << EOF
import re
file = open('scripts/globals/settings.lua', 'r')
data = file.read()
file.close()
# Find all settings names (ignoring comments, up to = character)
matches = re.findall(r'^(?!--).+?(?==)', data, re.MULTILINE)
# Make sure they're stripped of whitespace
matches = map(lambda s: s.strip(), matches)
# Print space-delimited for piping back to bash
print(*matches)
EOF`

printf "Gathering information on globals\n"
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
    Action
    interactionUtil

    SANDORIA
    BASTOK
    WINDURST
    ZILART
    TOAU
    WOTG
    COP
    ASSAULT
    CAMPAIGN
    ACP
    AMK
    ASA
    SOA
    ROV

    QUEST_AVAILABLE
    QUEST_ACCEPTED
    QUEST_COMPLETED

    GetMissionLogInfo
    GetQuestLogInfo

    SANDORIA
    BASTOK
    WINDURST
    JEUNO
    OTHER_AREAS
    OUTLANDS
    AHT_URHGAN
    CRYSTAL_WAR
    ABYSSEA
    ADOULIN
    COALITION

    SANDORIA
    BASTOK
    WINDURST
    JEUNO
    SELBINA
    MHAURA
    RABAO
    KAZHAM
    NORG
    OTHER_AREAS_LOG
    TAVNAZIA
    OUTLANDS
    ZILART
    COP
    TOAU
    AHT_URHGAN
    ASSAULT
    WOTG
    CRYSTAL_WAR
    CAMPAIGN
    ACP
    AMK
    ASA
    ABYSSEA
    ABYSSEA_KONSCHTAT
    ABYSSEA_TAHRONGI
    ABYSSEA_LATHEINE
    ABYSSEA_MISAREAUX
    ABYSSEA_VUNKERL
    ABYSSEA_ATTOHWA
    ABYSSEA_ALTEPA
    ABYSSEA_GRAUBERG
    ABYSSEA_ULEGUERAND
    SOA
    ADOULIN
    COALITION
    ROV
    QUEST_LOGS
    MISSION_LOGS

    TradeBCNM
    EventTriggerBCNM
    EventUpdateBCNM
    EventFinishBCNM

    onBattlefieldHandlerInitialise

    moogleTrade
    moogleTrigger
    moogleEventUpdate
    moogleEventFinish

    porterMoogleTrade
    porterEventUpdate
    porterEventFinish

    dynamis

    doPhysicalWeaponskill
    doRangedWeaponskill
    doMagicWeaponskill
    applyResistanceAddEffect

    updateModPerformance

    fTP

    PATHFLAG_WALLHACK

    RoeParseTimed
    getRoeRecords
    RoeParseRecords

    cmdprops
    error
    onTrigger
)

ignores=(
    "unused variable ID"
)

ignore_rules=(
    311 # value assigned to variable <> is unused
    542 # empty if branch
)

printf "Running luacheck\n"
~/.luarocks/bin/luacheck ${target} \
--quiet --jobs 4 --no-config --codes \
--no-unused-args \
--no-max-line-length \
--max-cyclomatic-complexity 30 \
--globals ${global_funcs[@]} ${global_objects[@]} ${settings_names[@]} \
--ignore ${ignores[@]} ${ignore_rules[@]} \
exit $?
