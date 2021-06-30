#!/bin/bash

# Requires the following packages:
# Package manager: luarocks
# luarocks install luacheck --local
# luarocks install lanes --local

target=${1:-scripts}

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
    item_utils

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
    Sequence
    Container
    Event
    onMobDeathEx

    checkForGearSet

    removeSleepEffects

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
    finishMissionTimeline
    getMissionOffset
    ORIGINAL_MISSION_OFFSET
    getMissionRankPoints
    getMissionMask

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

    doAutoPhysicalWeaponskill
    doAutoRangedWeaponskill
    doPhysicalWeaponskill
    doRangedWeaponskill
    doMagicWeaponskill
    doesElementMatchWeaponskill
    applyResistanceAddEffect
    takeWeaponskillDamage

    updateModPerformance

    fTP
    fSTR
    fSTR2
    calculateRawWSDmg
    calculatedIgnoredDef
    cMeleeRatio
    generatePdif
    getMeleeDmg
    handleWSGorgetBelt

    getRecommendedAssaultLevel

    PATHFLAG_WALLHACK

    RoeParseTimed
    getRoeRecords
    RoeParseRecords

    cmdprops
    error
    onTrigger

    unionRepresentativeTrade
    unionRepresentativeTrigger
    unionRepresentativeTriggerFinish

    tradeTestItem
    getTestItem
    isGuildMember
    getAdvImageSupportCost
    getCraftSkillCap
    signupGuild
    guild

    CheckMaps
    CheckMapsUpdate

    getDynamisMapList

    SetExplorerMoogles

    applyHalloweenNpcCostumes
    isHalloweenEnabled
    onHalloweenTrade
    HALLOWEEN_2008
    HALLOWEEN_2009
    HALLOWEEN_2010

    salvageUtil

    addMogLockerExpiryTime
    getMogLockerExpiryTimestamp
    unlockMogLocker
    getMogLockerAccessType
    setMogLockerAccessType

    addBonuses
    addBonusesAbility
    applyBarspell
    applyBarstatus
    applyPlayerResistance
    applyResistance
    applyResistanceAbility
    applyResistanceEffect
    adjustForTarget
    calculateDuration
    calculateDurationForLvl
    calculateMagicDamage
    calculatePotency
    canOverwrite
    dayWeatherBonus
    doBoostGain
    doDivineBanishNuke
    doDivineNuke
    doElementalNuke
    doEnspell
    doNinjutsuNuke
    finalMagicAdjustments
    finalMagicNonSpellAdjustments
    getBaseCure
    getCurePower
    getCurePowerOld
    getCureFinal
    getBaseCureOld
    getEffectResistance
    getElementalDamageReduction
    getElementalDebuffDOT
    getFlourishAnimation
    getHelixDuration
    getHitRate
    getMagicHitRate
    getMagicResist
    getStepAnimation
    getElementalDebuffStatDownFromDOT
    handleAfflatusMisery
    handleNinjutsuDebuff
    handleThrenody
    hasSleepEffects
    isValidHealTarget
    skillchainCount
    takeAbilityDamage
    mobAddBonuses
    MobBreathMove
    MobBuffMove
    MobDrainAttribute
    MobDrainMove
    MobDrainStatusEffectMove
    MobFormMagicBurst
    MobGazeMove
    MobHealMove
    MobMagicalMove
    MobPhysicalDrainMove
    MobPhysicalHit
    MobPhysicalMove
    MobRangedMove
    MobFinalAdjustments
    MobPhysicalStatusEffectMove
    MobStatusEffectMove

    FormMagicBurst

    BOMB_TOSS_HPP

    AbilityFinalAdjustments

    getSummoningSkillOverCap
    AvatarFinalAdjustments
    AvatarPhysicalHit
    AvatarPhysicalMove
    avatarMiniFightCheck

    TP_ACC_VARIES
    TP_ATK_VARIES
    TP_CRIT_VARIES
    TP_DMG_BONUS
    TP_DMG_VARIES
    TP_MAB_BONUS
    TP_MACC_BONUS
    TP_NO_EFFECT
    TP_RANGED

    MOBPARAM_1_SHADOW
    MOBPARAM_2_SHADOW
    MOBPARAM_3_SHADOW
    MOBPARAM_4_SHADOW
    MOBPARAM_BLUNT
    MOBPARAM_WIPE_SHADOWS
    MOBPARAM_IGNORE_SHADOWS
    MOBPARAM_DARK
    MOBPARAM_LIGHT
    MOBDRAIN_HP
    MOBDRAIN_MP
    MOBDRAIN_TP
    MOBTYPE_NORMAL
    MOBTYPE_0X01
    MOBTYPE_NOTORIOUS
    MOBTYPE_FISHED
    MOBTYPE_CALLED
    MOBTYPE_BATTLEFIELD
    MOBTYPE_EVENT

    MOBSKILL_MAGICAL
    MOBSKILL_PHYSICAL

    getMedalRank
    getBastokNotesItem
    getSandOriaNotesItem
    getWindurstNotesItem
    getSigilTimeStamp

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

    doRoyalPalaceArmorCheck

    MOGLOCKER_START_TS
    MOGLOCKER_ALZAHBI_VALID_DAYS
    MOGLOCKER_ALLAREAS_VALID_DAYS
    MOGLOCKER_ACCESS_TYPE_ALZAHBI
    MOGLOCKER_ACCESS_TYPE_ALLAREAS
    MOGLOCKER_PLAYERVAR_ACCESS_TYPE
    MOGLOCKER_PLAYERVAR_EXPIRY_TIMESTAMP
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
--globals ${global_funcs[@]} ${global_objects[@]} ${settings_names[@]} \
--ignore ${ignores[@]} ${ignore_rules[@]}
