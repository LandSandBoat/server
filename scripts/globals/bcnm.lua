-----------------------------------
-- BCNM Functions
-----------------------------------
require('scripts/globals/battlefield')
require('scripts/globals/missions')
require('scripts/globals/quests')
-----------------------------------
xi = xi or {}
xi.bcnm = xi.bcnm or {}

-- battlefields by zone
-- captured from client 2020-10-24
local battlefields =
{
--[[
    [zoneId] =
    {
        { bit, battlefieldIdInDatabase, requiredItemToTrade }
    },
--]]
    [xi.zone.BONEYARD_GULLY] =
    {
        { 0,  672,    0 },   -- Head Wind (PM5-3 U2)
    --  { 1,  673,    0 },   -- Like the Wind (ENM) -- TODO: mob constantly runs during battle
        { 2,  674,    0 },   -- Sheep in Antlion's Clothing (ENM)
    --  { 3,  675,    0 },   -- Shell We Dance? (ENM) -- TODO: Needs testing, cleanup, and mixin work
    --  { 4,  676,    0 },   -- Totentanz (ENM)
    --  { 5,  677,    0 },   -- Tango with a Tracker (Quest)
    --  { 6,  678,    0 },   -- Requiem of Sin (Quest)
    --  { 7,  679, 3454 },   -- Antagonistic Ambuscade (HKC30)
    --  { 8,    ?,    0 },   -- *Head Wind (HTMBF)
    },

    [xi.zone.THE_SHROUDED_MAW] =
    {
        { 0,  704,    0 },   -- Darkness Named (PM3-5)
    --  { 1,  705,    0 },   -- Test Your Mite (ENM)
        { 2,  706,    0 },   -- Waking Dreams (Quest)
    --  { 3,    ?,    0 },   -- *Waking Dreams (HTMBF)
    },

    [xi.zone.RIVERNE_SITE_B01] =
    {
        { 0,  896,    0 },   -- Storms of Fate (Quest)
    --  { 1,  897, 2108 },   -- The Wyrmking Descends (BCNM)
    },

    [xi.zone.MONARCH_LINN] =
    {
        { 0,  960,    0 },   -- Ancient Vows (PM2-5)
        { 1,  961,    0 },   -- The Savage (PM4-2)
    --  { 2,  962,    0 },   -- Fire in the Sky (ENM)
    --  { 3,  963,    0 },   -- Bad Seed (ENM)
    --  { 4,  964,    0 },   -- Bugard in the Clouds (ENM)
    --  { 5,  965,    0 },   -- Beloved of the Atlantes (ENM)
    --  { 6,  966,    0 },   -- Uninvited Guests (Quest)
    --  { 7,  967, 3455 },   -- Nest of Nightmares (HKC50)
    --  { 8,    ?,    0 },   -- *The Savage (HTMBF)
    },

    [xi.zone.SEALIONS_DEN] =
    {
        { 0,  992,    0 },   -- One to Be Feared (PM6-4)
        { 1,  993,    0 },   -- The Warrior's Path (PM7-5)
    --  { 2,    ?,    0 },   -- *The Warrior's Path (HTMBF)
    --  { 3,    ?,    0 },   -- *One to Be Feared (HTMBF)
    },

    [xi.zone.THE_GARDEN_OF_RUHMET] =
    {
        { 0, 1024,    0 },   -- When Angels Fall (PM8-3)
    },

    [xi.zone.EMPYREAL_PARADOX] =
    {
        { 0, 1056,    0 },   -- Dawn (PM8-4)
        { 1, 1057,    0 },   -- Apocalypse Nigh (Quest)
    --  { 2,    ?,    0 },   -- Both Paths Taken (ROVM2-9-2)
    --  { 3,    ?,    0 },   -- *Dawn (HTMBF)
    --  { 4,    ?,    0 },   -- The Winds of Time (ROVM3-1-26)
    --  { 5,    ?,    0 },   -- Sealed Fate (Master Trial)
    },

    [xi.zone.TALACCA_COVE] =
    {
    --  { 0, 1088,    0 },   -- Call to Arms (ISNM)
    --  { 1, 1089,    0 },   -- Compliments to the Chef (ISNM)
    --  { 2, 1090,    0 },   -- Puppetmaster Blues (Quest)
        { 3, 1091, 2332 },   -- Breaking the Bonds of Fate (COR LB5)
        { 4, 1092,    0 },   -- Legacy of the Lost (TOAU35)
    --  { 5,    ?,    0 },   -- *Legacy of the Lost (HTMBF)
    },

    [xi.zone.NAVUKGO_EXECUTION_CHAMBER] =
    {
    --  { 0, 1120,    0 },   -- Tough Nut to Crack (ISNM)
    --  { 1, 1121,    0 },   -- Happy Caster (ISNM)
        { 2, 1122,    0 },   -- Omens (BLU AF2)
        { 3, 1123, 2333 },   -- Achieving True Power (PUP LB5)
        { 4, 1124,    0 },   -- Shield of Diplomacy (TOAU22)
    },

    [xi.zone.JADE_SEPULCHER] =
    {
    --  { 0, 1152,    0 },   -- Making a Mockery (ISNM)
    --  { 1, 1153,    0 },   -- Shadows of the Mind (ISNM)
        { 2, 1154, 2331 },   -- The Beast Within (BLU LB5)
    --  { 3, 1155,    0 },   -- Moment of Truth (Quest)
        { 4, 1156,    0 },   -- Puppet in Peril (TOAU29)
    --  { 5,    ?,    0 },   -- *Puppet in Peril (HTMBF)
    },

    [xi.zone.LA_VAULE_S] =
    {
    --  { 0,    ?,    0 },   -- Splitting Heirs (S)
        { 1, 2721,    0 },   -- Purple, The New Black
    --  { 2,    ?,    0 },   -- The Blood-bathed Crown
    },

    [xi.zone.GHELSBA_OUTPOST] =
    {
        { 0,   32,    0 },   -- Save the Children (San d'Oria 1-3)
        { 1,   33,    0 },   -- The Holy Crest (Quest)
        { 2,   34, 1551 },   -- Wings of Fury (BS20) -- TODO: mobskills Slipstream and Turbulence
        { 3,   35, 1552 },   -- Petrifying Pair (BS30)
        { 4,   36, 1552 },   -- Toadal Recall (BS30) -- TODO: shroom-in-cap mechanic
    --  { 5,   37,    0 },   -- Mirror, Mirror (Quest)
    },

    [xi.zone.FULL_MOON_FOUNTAIN] =
    {
        { 0,  224,    0 },   -- The Moonlit Path (Quest)
        { 1,  225,    0 },   -- Moon Reading (Windurst 9-2)
    --  { 2,  226,    0 },   -- Waking the Beast (Quest)
    --  { 3,  227,    0 },   -- Battaru Royale (ASA10)
    --  { 4,    ?,    0 },   -- *The Moonlit Path (HTMBF)
    --  { 5,    ?,    0 },   -- *Waking the Beast (HTMBF)
    },
}

-----------------------------------
-- Check requirements for registrant and allies
-----------------------------------
local function checkReqs(player, npc, bfid, registrant)
    local battlefield = xi.battlefield.contents[bfid]
    if battlefield then
        return battlefield:checkRequirements(player, npc, registrant)
    end

    local npcId     = npc:getID()
    local mainJob   = player:getMainJob()
    local mainLevel = player:getMainLvl()

    local sandoriaMission  = player:getCurrentMission(xi.mission.log_id.SANDORIA)
    local windurstMission  = player:getCurrentMission(xi.mission.log_id.WINDURST)
    local promathiaMission = player:getCurrentMission(xi.mission.log_id.COP)
    local toauMission      = player:getCurrentMission(xi.mission.log_id.TOAU)
--  local acpMission       = player:getCurrentMission(xi.mission.log_id.ACP) NOTE: UNUSED Until BCNMID 532 is Re-enabled

    local nationStatus    = player:getMissionStatus(player:getNation())
    local promathiaStatus = player:getCharVar('PromathiaStatus')
    local toauStatus      = player:getMissionStatus(xi.mission.log_id.TOAU)

    local function getEntranceOffset(offset)
        return zones[player:getZoneID()].npc.ENTRANCE_OFFSET + offset
    end

    -- Requirements to register a battlefield
    local registerReqs =
    {
        [32] = function() -- San d'Oria 1-3: Save the Children
            local hasCompletedSaveTheChildren = player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SAVE_THE_CHILDREN)

            return sandoriaMission == xi.mission.id.sandoria.SAVE_THE_CHILDREN and
                (
                    (hasCompletedSaveTheChildren and nationStatus <= 2) or
                    (not hasCompletedSaveTheChildren and nationStatus == 2)
                )
        end,

        [33] = function() -- Quest: The Holy Crest
            return player:hasKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
        end,

        [163] = function() -- Quest: Survival of the Wisest (SCH LB5)
            return mainJob == xi.job.SCH and mainLevel >= 66
        end,

        [224] = function() -- Quest: The Moonlit Path
            return player:hasKeyItem(xi.ki.MOON_BAUBLE)
        end,

        [225] = function() -- Windurst 9-2: Moon Reading
            return windurstMission == xi.mission.id.windurst.MOON_READING and
                nationStatus == 2
        end,

        [530] = function() -- Quest: A Furious Finale (DNC LB5)
            return mainJob == xi.job.DNC and mainLevel >= 66
        end,

        [641] = function() -- ENM: Follow the White Rabbit
            return player:hasKeyItem(xi.ki.ZEPHYR_FAN) and npcId == getEntranceOffset(2)
        end,

        [642] = function() -- ENM: When Hell Freezes Over
            return player:hasKeyItem(xi.ki.ZEPHYR_FAN) and npcId == getEntranceOffset(4)
        end,

        [672] = function() -- PM5-3 U2: Head Wind
            return promathiaMission == xi.mission.id.cop.THREE_PATHS and
                player:getMissionStatus(xi.mission.log_id.COP, xi.mission.status.COP.ULMIA) == 7
        end,

        [673] = function() -- ENM: Like the Wind
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [674] = function() -- ENM: Sheep in Antlion's Clothing
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [675] = function() -- ENM: Shell We Dance?
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [676] = function() -- ENM: Totentanz
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [677] = function() -- Quest: Tango with a Tracker
            return player:hasKeyItem(xi.ki.LETTER_FROM_SHIKAREE_X)
        end,

        [678] = function() -- Quest: Requiem of Sin
            return player:hasKeyItem(xi.ki.LETTER_FROM_SHIKAREE_Y)
        end,

        [704] = function() -- PM3-5: Darkness Named
            return promathiaMission == xi.mission.id.cop.DARKNESS_NAMED and
                player:getCharVar('Mission[6][358]Status') == 4
        end,

        [705] = function() -- ENM: Test Your Mite
            return player:hasKeyItem(xi.ki.ASTRAL_COVENANT)
        end,

        [706] = function() -- Quest: Waking Dreams
            return player:hasKeyItem(xi.ki.VIAL_OF_DREAM_INCENSE)
        end,

        [738] = function() -- ENM: Bionic Bug
            return player:hasKeyItem(xi.ki.SHAFT_2716_OPERATING_LEVER)
        end,

        [739] = function() -- ENM: Pulling Your Strings
            return player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL)
        end,

        [740] = function() -- ENM: Automaton Assault
            return player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL)
        end,

        [769] = function() -- ENM: Simulant
            return player:hasKeyItem(xi.ki.CENSER_OF_ABANDONMENT)
        end,

        [801] = function() -- ENM: You Are What You Eat
            return player:hasKeyItem(xi.ki.CENSER_OF_ANTIPATHY)
        end,

        [833] = function() -- ENM: Playing Host
            return player:hasKeyItem(xi.ki.CENSER_OF_ANIMUS)
        end,

        [865] = function() -- ENM: Pulling the Plug
            return player:hasKeyItem(xi.ki.CENSER_OF_ACRIMONY)
        end,

        [896] = function() -- Quest: Storms of Fate
            return player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == xi.questStatus.QUEST_ACCEPTED and
                player:getCharVar('StormsOfFate') == 2
        end,

        [960] = function() -- PM2-5: Ancient Vows
            return promathiaMission == xi.mission.id.cop.ANCIENT_VOWS and
                player:getCharVar('Mission[6][248]Status') == 2 and
                player:getPreviousZone() == xi.zone.RIVERNE_SITE_A01
        end,

        [961] = function() -- PM4-2: The Savage
            return promathiaMission == xi.mission.id.cop.THE_SAVAGE and
                player:getCharVar('Mission[6][418]Status') == 1 and
                player:getPreviousZone() == xi.zone.RIVERNE_SITE_B01
        end,

        [962] = function() -- ENM: Fire in the Sky
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [963] = function() -- ENM: Bad Seed
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [964] = function() -- ENM: Bugard in the Clouds
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [965] = function() -- ENM: Beloved of Atlantes
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [992] = function() -- PM6-4: One to be Feared
            return promathiaMission == xi.mission.id.cop.ONE_TO_BE_FEARED and
                player:getCharVar('Mission[6][638]Status') == 3
        end,

        [993] = function() -- PM7-5: The Warrior's Path
            return promathiaMission == xi.mission.id.cop.THE_WARRIORS_PATH and
                player:getCharVar('Mission[6][748]Status') == 1
        end,

        [1024] = function() -- PM8-3: When Angels Fall
            return promathiaMission == xi.mission.id.cop.WHEN_ANGELS_FALL and
                promathiaStatus == 4
        end,

        [1056] = function() -- PM8-4: Dawn
            return promathiaMission == xi.mission.id.cop.DAWN and
                promathiaStatus == 2
        end,

        [1057] = function() -- Apocalypse Nigh
            return player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == xi.questStatus.QUEST_ACCEPTED and
                player:getCharVar('ApocalypseNigh') == 4
        end,

        [1090] = function() -- Quest: Puppetmaster Blues
            return player:hasKeyItem(xi.ki.TOGGLE_SWITCH)
        end,

        [1091] = function() -- Quest: Breaking the Bonds of Fate (COR LB5)
            return mainJob == xi.job.COR and mainLevel >= 66
        end,

        [1092] = function() -- TOAU35: Legacy of the Lost
            return toauMission == xi.mission.id.toau.LEGACY_OF_THE_LOST
        end,

        [1122] = function() -- Quest: Omens (BLU AF Quest 2)
            return player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.OMENS) == xi.questStatus.QUEST_ACCEPTED and
                xi.quest.getVar(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.OMENS, 'Prog') == 0
        end,

        [1123] = function() -- Quest: Achieving True Power (PUP LB5)
            return mainJob == xi.job.PUP and mainLevel >= 66
        end,

        [1124] = function() -- TOAU22: Shield of Diplomacy
            return toauMission == xi.mission.id.toau.SHIELD_OF_DIPLOMACY and toauStatus == 2
        end,

        [1154] = function() -- Quest: The Beast Within (BLU LB5)
            return mainJob == xi.job.BLU and mainLevel >= 66
        end,

        [1156] = function() -- TOAU29: Puppet in Peril
            return toauMission == xi.mission.id.toau.PUPPET_IN_PERIL and toauStatus == 1
        end,

        [2721] = function() -- WOTG07: Purple, The New Black
            return player:getCurrentMission(xi.mission.log_id.WOTG) == xi.mission.id.wotg.PURPLE_THE_NEW_BLACK and
                player:getMissionStatus(xi.mission.log_id.WOTG) == 1
        end,
    }

    -- Requirements to enter a battlefield already registered by a party member
    local enterReqs =
    {
        [640] = function() -- PM5-3 U3: Flames for the Dead
            return npc:getXPos() > -721 and npc:getXPos() < 719
        end,

        [641] = function() -- ENM: Follow the White Rabbit
            return player:hasKeyItem(xi.ki.ZEPHYR_FAN)
        end,

        [642] = function() -- ENM: When Hell Freezes Over
            return player:hasKeyItem(xi.ki.ZEPHYR_FAN)
        end,

        [673] = function() -- ENM: Like the Wind
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [674] = function() -- ENM: Sheep in Antlion's Clothing
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [675] = function() -- ENM: Shell We Dance?
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [676] = function() -- ENM: Totentanz
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [705] = function() -- ENM: Test Your Mite
            return player:hasKeyItem(xi.ki.ASTRAL_COVENANT)
        end,

        [738] = function() -- ENM: Bionic Bug
            return player:hasKeyItem(xi.ki.SHAFT_2716_OPERATING_LEVER)
        end,

        [739] = function() -- ENM: Pulling Your Strings
            return player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL)
        end,

        [740] = function() -- ENM: Automaton Assault
            return player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL)
        end,

        [769] = function() -- ENM: Simulant
            return player:hasKeyItem(xi.ki.CENSER_OF_ABANDONMENT)
        end,

        [801] = function() -- ENM: You Are What You Eat
            return player:hasKeyItem(xi.ki.CENSER_OF_ANTIPATHY)
        end,

        [833] = function() -- ENM: Playing Host
            return player:hasKeyItem(xi.ki.CENSER_OF_ANIMUS)
        end,

        [865] = function() -- ENM: Pulling the Plug
            return player:hasKeyItem(xi.ki.CENSER_OF_ACRIMONY)
        end,

        [897] = function() -- Quest: The Wyrmking Descends
            return player:hasKeyItem(xi.ki.WHISPER_OF_THE_WYRMKING)
        end,

        [962] = function() -- ENM: Fire in the Sky
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [963] = function() -- ENM: Bad Seed
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [964] = function() -- ENM: Bugard in the Clouds
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [965] = function() -- ENM: Beloved of Atlantes
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [928] = function() -- Quest: Ouryu Cometh
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS) or
                (
                    promathiaMission == xi.mission.id.cop.ANCIENT_VOWS and
                    player:getCharVar('Mission[6][248]Status') >= 2
                )
        end,

        [1057] = function() -- Quest: Apocalypse Nigh
            return player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) or
                (
                    player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == xi.questStatus.QUEST_ACCEPTED and
                    player:getCharVar('ApocalypseNigh') == 4
                )
        end,

        [2721] = function() -- WOTG07: Purple, The New Black
            return player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.PURPLE_THE_NEW_BLACK)
        end,
    }

    -- Determine whether player meets battlefield requirements
    local req = registrant and registerReqs[bfid] or enterReqs[bfid]

    if not req or req() then
        return true
    else
        return false
    end
end

-----------------------------------
-- check ability to skip a cutscene
-----------------------------------
local function checkSkip(player, bfid)
    local battlefield = xi.battlefield.contents[bfid]
    if battlefield then
        return battlefield:checkSkipCutscene(player)
    end

    local sandoriaMission  = player:getCurrentMission(xi.mission.log_id.SANDORIA)
    local bastokMission    = player:getCurrentMission(xi.mission.log_id.BASTOK)
    local windurstMission  = player:getCurrentMission(xi.mission.log_id.WINDURST)
    local promathiaMission = player:getCurrentMission(xi.mission.log_id.COP)

    local nationStatus    = player:getMissionStatus(player:getNation())
    local promathiaStatus = player:getCharVar('PromathiaStatus')

    -- Requirements to skip a battlefield
    local skipReqs =
    {
        [32] = function() -- San d'Oria 1-3: Save the Children
            return player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SAVE_THE_CHILDREN) or
                (
                    sandoriaMission == xi.mission.id.sandoria.SAVE_THE_CHILDREN and
                    nationStatus > 2
                )
        end,

        [33] = function() -- Quest: The Holy Crest
            return player:hasCompletedQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST)
        end,

        [161] = function() -- Bastok 9-2: Where Two Paths Converge
            return player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE) or
                (
                    bastokMission == xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE and
                    nationStatus > 4
                )
        end,

        [224] = function() -- Quest: The Moonlit Path
            return player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.THE_MOONLIT_PATH) or
                player:hasKeyItem(xi.ki.WHISPER_OF_THE_MOON)
        end,

        [225] = function() -- windurstMission 9-2: Moon Reading
            return player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING) or
                (
                    windurstMission == xi.mission.id.windurst.MOON_READING and
                    nationStatus > 4
                )
        end,

        [672] = function() -- PM5-3 U2: Head Wind
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS) or
                (
                    promathiaMission == xi.mission.id.cop.THREE_PATHS and
                    player:getMissionStatus(xi.mission.log_id.COP, xi.mission.status.COP.ULMIA) > 7
                )
        end,

        [704] = function() -- PM3-5: Darkness Named
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) or
                (
                    promathiaMission == xi.mission.id.cop.DARKNESS_NAMED and
                    player:getCharVar('Mission[6][358]Status') == 5
                )
        end,

        [706] = function() -- Quest: Waking Dreams
            return player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.WAKING_DREAMS) or
                player:hasKeyItem(xi.ki.WHISPER_OF_DREAMS)
        end,

        [896] = function() -- Quest: Storms of Fate
            local stormsOfFateStatus = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE)

            return stormsOfFateStatus == xi.questStatus.QUEST_COMPLETED or
                (
                    stormsOfFateStatus == xi.questStatus.QUEST_ACCEPTED and
                    player:getCharVar('StormsOfFate') > 2
                )
        end,

        [960] = function() -- PM2-5: Ancient Vows
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS)
        end,

        [961] = function() -- PM4-2: The Savage
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SAVAGE) or
                (
                    promathiaMission == xi.mission.id.cop.THE_SAVAGE and
                    player:getCharVar('Mission[6][418]Status') > 1
                )
        end,

        [993] = function() -- PM7-5: The Warrior's Path
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH)
        end,

        [1024] = function() -- PM8-3: When Angels Fall
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL) or
                (
                    promathiaMission == xi.mission.id.cop.WHEN_ANGELS_FALL and
                    promathiaStatus > 4
                )
        end,

        [1056] = function() -- PM8-4: Dawn
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN) or
                (
                    promathiaMission == xi.mission.id.cop.DAWN and
                    promathiaStatus > 2
                )
        end,

        [1057] = function() -- Apocalypse Nigh
            return player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)
        end,

        [2721] = function() -- WOTG07: Purple, The New Black
            return player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.PURPLE_THE_NEW_BLACK)
        end,
    }

    -- Determine whether player meets cutscene skip requirements
    local req = skipReqs[bfid]

    if not req then
        return false
    elseif req() then
        return true
    end

    return false
end

-----------------------------------
-- Which battlefields are valid for registrant?
-----------------------------------
local function findBattlefields(player, npc, itemId)
    local mask = 0
    local zbfs = battlefields[player:getZoneID()]

    if zbfs == nil then
        return 0
    end

    for k, v in pairs(zbfs) do
        if
            v[3] == itemId and
            checkReqs(player, npc, v[2], true) and
            not player:battlefieldAtCapacity(v[2])
        then
            mask = bit.bor(mask, math.pow(2, v[1]))
        end
    end

    return mask
end

-----------------------------------
-- Get battlefield id for a given zone and bit
-----------------------------------
local function getBattlefieldIdByBit(player, bit)
    local zbfs = battlefields[player:getZoneID()]

    if not zbfs then
        return 0
    end

    for k, v in pairs(zbfs) do
        if v[1] == bit then
            return v[2]
        end
    end

    return 0
end

-----------------------------------
-- Get battlefield bit for a given zone and id
-----------------------------------
local function getBattlefieldMaskById(player, bfid)
    local zbfs = battlefields[player:getZoneID()]

    if zbfs then
        for k, v in pairs(zbfs) do
            if v[2] == bfid then
                return math.pow(2, v[1])
            end
        end
    end

    return 0
end

-----------------------------------
-- Get battlefield bit for a given zone and id
-----------------------------------
local function getItemById(player, bfid)
    local zbfs = battlefields[player:getZoneID()]

    if zbfs then
        for k, v in pairs(zbfs) do
            if v[2] == bfid then
                return v[3]
            end
        end
    end

    return 0
end

-----------------------------------
-- onTrade Action
-----------------------------------

xi.bcnm.onTrade = function(player, npc, trade, onUpdate)
    if xi.battlefield.rejectLevelSyncedParty(player, npc) then -- player's party has level sync, abort.
        return false
    end

    -- Validate trade
    local itemId

    if not trade then
        return false

    -- Chips for limbus
    elseif npcUtil.tradeHasExactly(trade, { xi.item.SILVER_CHIP, xi.item.CERULEAN_CHIP, xi.item.ORCHID_CHIP }) then
        itemId = -1

    -- Chips for limbus
    elseif npcUtil.tradeHasExactly(trade, { xi.item.SMALT_CHIP, xi.item.SMOKY_CHIP, xi.item.CHARCOAL_CHIP, xi.item.MAGENTA_CHIP }) then
        itemId = -2

    -- Orbs / Testimonies
    else
        itemId = trade:getItemId(0)

        if
            itemId == nil or
            itemId < 1 or
            itemId > 65535 or
            trade:getItemCount() ~= 1 or
            trade:getSlotQty(0) ~= 1
        then
            return false

        -- Check for already used Orb or testimony.
        elseif player:getWornUses(itemId) > 0 then
            player:messageBasic(xi.msg.basic.ITEM_UNABLE_TO_USE_2, 0, 0) -- Unable to use item.
            return false
        end
    end

    -- Validate battlefield status
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) and not onUpdate then
        player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0) -- You must wait longer to perform that action.

        return false
    end

    -- Check if another party member has battlefield status effect. If so, don't allow trade.
    local alliance = player:getAlliance()
    for _, member in pairs(alliance) do
        if member:hasStatusEffect(xi.effect.BATTLEFIELD) then
            player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0) -- You must wait longer to perform that action.

            return false
        end
    end

    -- Open menu of valid battlefields
    local validBattlefields = findBattlefields(player, npc, itemId)

    if validBattlefields ~= 0 then
        if not onUpdate then
            player:startEvent(32000, 0, 0, 0, validBattlefields, 0, 0, 0, 0)
        end

        return true
    end

    return false
end

-----------------------------------
-- onTrigger Action
-----------------------------------
xi.bcnm.onTrigger = function(player, npc)
    -- Cannot enter if anyone in party is level/master sync'd
    if xi.battlefield.rejectLevelSyncedParty(player, npc) then
        return false
    end

    -- Player has battlefield status effect. That means a battlefield is open OR the player is inside a battlefield.
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        -- Player is inside battlefield. Attempting to leave.
        if player:getBattlefield() then
            player:startOptionalCutscene(32003)

            return true

        -- Player is outside battlefield. Attempting to enter.
        else
            local stat = player:getStatusEffect(xi.effect.BATTLEFIELD)
            local bfid = stat:getPower()
            local mask = getBattlefieldMaskById(player, bfid)

            if mask ~= 0 and checkReqs(player, npc, bfid, false) then
                player:startEvent(32000, 0, 0, 0, mask, 0, 0, 0, 0)

                return true
            end
        end

    -- Player doesn't have battlefield status effect. That means player wants to register a new battlefield OR is attempting to enter a closed one.
    else
        -- Check if another party member has battlefield status effect. If so, that means the player is trying to enter a closed battlefield.
        local alliance = player:getAlliance()
        for _, member in pairs(alliance) do
            if member:hasStatusEffect(xi.effect.BATTLEFIELD) then
                -- player:messageSpecial() -- You are eligible but cannot enter.

                return false
            end
        end

        -- No one in party/alliance has battlefield status effect. We want to register a new battlefield.
        local mask = findBattlefields(player, npc, 0)

        -- GMs get access to all BCNMs
        if player:getGMLevel() > 0 and player:getVisibleGMLevel() >= 3 then
            mask = 268435455
        end

        -- mask = 268435455 -- uncomment to open menu with all possible battlefields
        if mask ~= 0 then
            player:startEvent(32000, 0, 0, 0, mask, 0, 0, 0, 0)
            return true
        end
    end

    return false
end

-----------------------------------
-- onEventUpdate
-----------------------------------
xi.bcnm.onEventUpdate = function(player, csid, option, extras)
    -- player:printToPlayer(string.format('EventUpdateBCNM csid=%i option=%i extras=%i', csid, option, extras))

    -- Requesting a battlefield
    if csid == 32000 then
        if option == 0 then
            -- todo: check if battlefields full, check party member requiremenst
            return 0
        elseif option == 255 then
            -- todo: check if battlefields full, check party member requirements
            return 0
        end

        local area = player:getLocalVar('[battlefield]area')
        area       = area + 1

        local battlefieldIndex = bit.rshift(option, 4)
        local battlefieldId    = getBattlefieldIdByBit(player, battlefieldIndex)
        local id               = battlefieldId or player:getBattlefieldID()
        local skip             = checkSkip(player, id)

        local clearTime = 1
        local name      = 'Meme'
        local partySize = 1

        local result = xi.battlefield.returnCode.REQS_NOT_MET
        result       = player:registerBattlefield(id, area)
        local status = xi.battlefield.status.OPEN

        if result ~= xi.battlefield.returnCode.CUTSCENE then
            if result == xi.battlefield.returnCode.INCREMENT_REQUEST then
                if area < 3 then
                    player:setLocalVar('[battlefield]area', area)
                else
                    result = xi.battlefield.returnCode.WAIT
                    player:updateEvent(result)
                end
            end

            return false
        else
            -- Only allow entrance if battlefield is open and playerhas battlefield effect, witch can be lost mid battlefield selection.
            if
                not player:getBattlefield() and
                player:hasStatusEffect(xi.effect.BATTLEFIELD)
                -- and id:getStatus() == xi.battlefield.status.OPEN -- TODO: Uncomment only once that can-of-worms is dealt with.
            then
                player:enterBattlefield()
            end

            -- Handle record
            local initiatorId   = 0
            local initiatorName = ''
            local battlefield   = player:getBattlefield()

            if battlefield then
                battlefield:setLocalVar('[cs]bit', battlefieldIndex)
                name, clearTime, partySize = battlefield:getRecord()
                initiatorId, initiatorName = battlefield:getInitiator()
            end

            -- Register party members
            if initiatorId == player:getID() then
                local effect = player:getStatusEffect(xi.effect.BATTLEFIELD)
                local zone   = player:getZoneID()
                local item   = getItemById(player, effect:getPower())

                -- Handle traded items
                if item ~= 0 then
                    -- Remove limbus chips
                    if zone == 37 or zone == 38 then
                        player:tradeComplete()

                    -- Set other traded item to worn
                    elseif player:hasItem(item) and player:getName() == initiatorName then
                        player:incrementItemWear(item)
                    end
                end

                -- Handle party/alliance members
                local alliance = player:getAlliance()
                for _, member in pairs(alliance) do
                    if
                        member:getZoneID() == zone and
                        not member:hasStatusEffect(xi.effect.BATTLEFIELD) and
                        not member:getBattlefield()
                    then
                        member:addStatusEffect(effect)
                        member:registerBattlefield(id, area, player:getID())
                    end
                end
            end
        end

        player:updateEvent(result, battlefieldIndex, 0, clearTime, partySize, skip)
        player:updateEventString(name)
        return status < xi.battlefield.status.LOCKED and result < xi.battlefield.returnCode.LOCKED

    -- Leaving a battlefield
    elseif csid == 32003 and option == 2 then
        player:updateEvent(3)
        return true
    elseif csid == 32003 and option == 3 then
        player:updateEvent(0)
        return true
    end

    return false
end

-----------------------------------
-- onEventFinish Action
-----------------------------------

xi.bcnm.onEventFinish = function(player, csid, option, npc)
    -- player:printToPlayer(string.format('EventFinishBCNM csid=%i option=%i', csid, option))
    player:setLocalVar('[battlefield]area', 0)

    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        if csid == 32003 and option == 4 then
            if player:getBattlefield() then
                player:leaveBattlefield(1)
            end
        end

        return true
    end

    return false
end
