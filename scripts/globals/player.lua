require('scripts/globals/abyssea')
require("scripts/globals/gear_sets")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/teleports")
require("scripts/globals/titles")
require("scripts/globals/zone")
require("scripts/globals/events/login_campaign")
-----------------------------------
require("scripts/quests/full_speed_ahead")
-----------------------------------

local startingRaceInfo =
{
    [xi.race.HUME_M]   = { gear = { body = 12631, hand = 12754, leg = 12883, feet = 13005 }, homeNation = xi.nation.BASTOK },
    [xi.race.HUME_F]   = { gear = { body = 12632, hand = 12760, leg = 12884, feet = 13010 }, homeNation = xi.nation.BASTOK },
    [xi.race.ELVAAN_M] = { gear = { body = 12633, hand = 12755, leg = 12885, feet = 13006 }, homeNation = xi.nation.SANDORIA },
    [xi.race.ELVAAN_F] = { gear = { body = 12634, hand = 12759, leg = 12889, feet = 13011 }, homeNation = xi.nation.SANDORIA },
    [xi.race.TARU_M]   = { gear = { body = 12635, hand = 12756, leg = 12886, feet = 13007 }, homeNation = xi.nation.WINDURST },
    [xi.race.TARU_F]   = { gear = { body = 12635, hand = 12756, leg = 12886, feet = 13007 }, homeNation = xi.nation.WINDURST },
    [xi.race.MITHRA]   = { gear = { body = 12636, hand = 12757, leg = 12887, feet = 13008 }, homeNation = xi.nation.WINDURST },
    [xi.race.GALKA]    = { gear = { body = 12637, hand = 12758, leg = 12888, feet = 13009 }, homeNation = xi.nation.BASTOK },
}

local startingNationInfo =
{
    [xi.nation.SANDORIA] = { ring = 13495, map = xi.ki.MAP_OF_THE_SAN_DORIA_AREA },
    [xi.nation.BASTOK]   = { ring = 13497, map = xi.ki.MAP_OF_THE_BASTOK_AREA },
    [xi.nation.WINDURST] = { ring = 13496, map = xi.ki.MAP_OF_THE_WINDURST_AREA },
}

local startingJobGear =
{
    [xi.job.WAR] = { 16534 },       -- onion sword
    [xi.job.MNK] = { 13184 },       -- white belt
    [xi.job.WHM] = { 17068, 4608 }, -- onion rod, scroll of cure
    [xi.job.BLM] = { 17104, 4607 }, -- onion staff, scroll of stone
    [xi.job.RDM] = { 16482, 4606 }, -- onion dagger, scroll of dia
    [xi.job.THF] = { 16483 },       -- onion knife
}

-----------------------------------
-- public functions
-----------------------------------

xi = xi or {}
xi.player = {}

xi.player.charCreate = function(player)
    local race = player:getRace()
    local raceInfo = startingRaceInfo[race]
    local nation = player:getNation()
    local nationInfo = startingNationInfo[nation]

    -- add race-specific starting gear
    for _, v in pairs(raceInfo.gear) do
        if not player:hasItem(v) then
            player:addItem(v)
            player:equipItem(v)
        end
    end

    -- add job-specific starting gear
    for _, v in pairs(startingJobGear[player:getMainJob()]) do
        if not player:hasItem(v) then
            player:addItem(v)
        end
    end

    -- add nation-specific map
    player:addKeyItem(nationInfo.map)

    -- add job-emote Key items
    player:addKeyItem(xi.ki.JOB_GESTURE_WARRIOR)
    player:addKeyItem(xi.ki.JOB_GESTURE_MONK)
    player:addKeyItem(xi.ki.JOB_GESTURE_WHITE_MAGE)
    player:addKeyItem(xi.ki.JOB_GESTURE_BLACK_MAGE)
    player:addKeyItem(xi.ki.JOB_GESTURE_RED_MAGE)
    player:addKeyItem(xi.ki.JOB_GESTURE_THIEF)

    -- add nation- and race-specific ring
    if nation == raceInfo.homeNation and not player:hasItem(nationInfo.ring) then
        player:addItem(nationInfo.ring)
    end

    -- unlock advanced jobs
    if xi.settings.main.ADVANCED_JOB_LEVEL == 0 then
        for i = xi.job.PLD, xi.job.SCH do
            player:unlockJob(i)
        end
    end

    -- unlock subjob
    if xi.settings.main.SUBJOB_QUEST_LEVEL == 0 then
        player:unlockJob(0)
    end

    -- give all maps
    if xi.settings.main.ALL_MAPS == 1 then
        for i = xi.ki.MAP_OF_THE_SAN_DORIA_AREA, xi.ki.MAP_OF_DIO_ABDHALJS_GHELSBA do
            player:addKeyItem(i)
        end

        for i = xi.ki.MAP_OF_AL_ZAHBI, xi.ki.MAP_OF_RAKAZNAR do
            player:addKeyItem(i)
        end

        for i = xi.ki.MAP_OF_RALA_WATERWAYS_U, xi.ki.MAP_OF_RAKAZNAR_U do
            player:addKeyItem(i)
        end

        for i = xi.ki.MAP_OF_ESCHA_ZITAH, xi.ki.MAP_OF_REISENJIMA do
            player:addKeyItem(i)
        end
    end

    -- set initial level cap
    if xi.settings.main.INITIAL_LEVEL_CAP ~= 50 then
        player:setLevelCap(xi.settings.main.INITIAL_LEVEL_CAP)
    end

    -- increase starting inventory
    if xi.settings.main.START_INVENTORY > 30 then
        player:changeContainerSize(xi.inv.INVENTORY, xi.settings.main.START_INVENTORY - 30)
        player:changeContainerSize(xi.inv.MOGSATCHEL, xi.settings.main.START_INVENTORY - 30)
    end

    --[[
        For some intermittent reason m_ZoneList ends up empty on characters, which is
        possibly also why they lose key items.  When that happens, CharCreate will be run and
        they end up losing their gil to the code below.  Added a conditional to hopefully
        prevent that until the bug is fixed.  Used the if instead of addGil to prevent abuse
        on servers with very high values of START_GIL, I guess.
    --]]

    if player:getGil() < xi.settings.main.START_GIL then
        player:setGil(xi.settings.main.START_GIL)
    end

    if xi.settings.main.NEW_CHARACTER_CUTSCENE == 0 then -- Do things that would normally be done in opening cutscene.
        player:addItem(xi.items.ADVENTURERS_COUPON)
        player:setHomePoint()
    end

    player:addTitle(xi.title.NEW_ADVENTURER)
    player:setCharVar("HQuest[moghouseExpo]notSeen", 1) -- needs Moghouse intro
    player:setCharVar("spokeKindlix", 1)                -- Kindlix introduction
    player:setCharVar("spokePyropox", 1)                -- Pyropox introduction
    player:setCharVar("TutorialProgress", 1)            -- Has not started tutorial
    player:setCharVar("EinherjarIntro", 1)              -- Has not seen Einherjar intro
    player:setNewPlayer(true)                           -- apply new player flag
end

-- called by core after a player logs into the server or zones
xi.player.onGameIn = function(player, firstLogin, zoning)
    if not zoning then
        -- things checked ONLY during logon go here
        if firstLogin then
            xi.player.charCreate(player)
        end
    else
        -- things checked ONLY during zone in go here
        if
            player:getLocalVar('gameLogin') == 1 and
            xi.abyssea.isInAbysseaZone(player) and
            not player:hasStatusEffect(xi.effect.VISITANT)
        then
            local zoneID = player:getZoneID()
            local ID = zones[zoneID]

            player:messageSpecial(ID.text.ABYSSEA_TIME_OFFSET + 8)
            player:setPos(unpack(xi.abyssea.exitPositions[zoneID]))
        end

        player:setLocalVar('gameLogin', 0)
    end

    -- Abyssea starting quest should be flagged when expansion is active
    if
        xi.settings.main.ENABLE_ABYSSEA == 1 and
        player:getQuestStatus(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.A_JOURNEY_BEGINS) == QUEST_AVAILABLE
    then
        player:addQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.A_JOURNEY_BEGINS)
    end

    -- This is for migration safety only, and should be removed at a later date
    if
        player:hasCompletedQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.A_JOURNEY_BEGINS) and
        player:getTraverserEpoch() == 0
    then
        player:setTraverserEpoch()
    end

    -- apply mods from gearsets (scripts/globals/gear_sets.lua)
    xi.gear_sets.checkForGearSet(player)

    -- god mode
    if player:getCharVar("GodMode") == 1 then
        player:addStatusEffect(xi.effect.MAX_HP_BOOST, 1000, 0, 0)
        player:addStatusEffect(xi.effect.MAX_MP_BOOST, 1000, 0, 0)
        player:addStatusEffect(xi.effect.MIGHTY_STRIKES, 1, 0, 0)
        player:addStatusEffect(xi.effect.HUNDRED_FISTS, 1, 0, 0)
        player:addStatusEffect(xi.effect.CHAINSPELL, 1, 0, 0)
        player:addStatusEffect(xi.effect.PERFECT_DODGE, 1, 0, 0)
        player:addStatusEffect(xi.effect.INVINCIBLE, 1, 0, 0)
        player:addStatusEffect(xi.effect.ELEMENTAL_SFORZO, 1, 0, 0)
        player:addStatusEffect(xi.effect.MANAFONT, 1, 0, 0)
        player:addStatusEffect(xi.effect.REGAIN, 300, 0, 0)
        player:addStatusEffect(xi.effect.REFRESH, 99, 0, 0)
        player:addStatusEffect(xi.effect.REGEN, 99, 0, 0)
        player:addMod(xi.mod.RACC, 2500)
        player:addMod(xi.mod.RATT, 2500)
        player:addMod(xi.mod.ACC, 2500)
        player:addMod(xi.mod.ATT, 2500)
        player:addMod(xi.mod.MATT, 2500)
        player:addMod(xi.mod.MACC, 2500)
        player:addMod(xi.mod.RDEF, 2500)
        player:addMod(xi.mod.DEF, 2500)
        player:addMod(xi.mod.MDEF, 2500)
        player:addHP(50000)
        player:setMP(50000)
    end

    -- !immortal
    if player:getCharVar("Immortal") == 1 then
        player:setUnkillable(true)
    end

    -- !hide
    if player:getCharVar("GMHidden") == 1 then
        player:setGMHidden(true)
    end

    -- remember time player zoned in (e.g., to support zone-in delays)
    player:setLocalVar("ZoneInTime", os.time())

    -- Slight delay to ensure player is fully logged in
    player:timer(2500, function(playerArg)
        -- Login Campaign rewards points once daily
        xi.events.loginCampaign.onGameIn(playerArg)
    end)
end

xi.player.onPlayerDeath = function(player)
end

xi.player.onPlayerLevelUp = function(player)
end

xi.player.onPlayerLevelDown = function(player)
end

xi.player.onPlayerMount = function(player)
    -- For PM3-3 The Road Forks.  This value will be checked periodically, and break
    -- the Mimeo Jewel should a player be mounted, zone, or disconnect.
    if
        player:getZoneID() == xi.zone.ATTOHWA_CHASM and
        player:hasKeyItem(xi.ki.MIMEO_JEWEL)
    then
        player:messageSpecial(zones[xi.zone.ATTOHWA_CHASM].text.MIMEO_JEWEL_OFFSET + 4, xi.ki.MIMEO_JEWEL)
        player:delKeyItem(xi.ki.MIMEO_JEWEL)
    end
end

xi.player.onPlayerEmote = function(player, emoteId)
    if
        emoteId == xi.emote.CHEER and
        player:hasStatusEffect(xi.effect.FULL_SPEED_AHEAD)
    then
        xi.fsa.onCheer(player)
    end
end

xi.player.onPlayerVolunteer = function(player, text)
end

return xi.player
