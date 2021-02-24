require("scripts/globals/gear_sets")
require("scripts/globals/keyitems")
require("scripts/settings/main")
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
    [xi.race.HUME_M]   = {gear = {body = 12631, hand = 12754, leg = 12883, feet = 13005}, homeNation = xi.nation.BASTOK},
    [xi.race.HUME_F]   = {gear = {body = 12632, hand = 12760, leg = 12884, feet = 13010}, homeNation = xi.nation.BASTOK},
    [xi.race.ELVAAN_M] = {gear = {body = 12633, hand = 12755, leg = 12885, feet = 13006}, homeNation = xi.nation.SANDORIA},
    [xi.race.ELVAAN_F] = {gear = {body = 12634, hand = 12759, leg = 12889, feet = 13011}, homeNation = xi.nation.SANDORIA},
    [xi.race.TARU_M]   = {gear = {body = 12635, hand = 12756, leg = 12886, feet = 13007}, homeNation = xi.nation.WINDURST},
    [xi.race.TARU_F]   = {gear = {body = 12635, hand = 12756, leg = 12886, feet = 13007}, homeNation = xi.nation.WINDURST},
    [xi.race.MITHRA]   = {gear = {body = 12636, hand = 12757, leg = 12887, feet = 13008}, homeNation = xi.nation.WINDURST},
    [xi.race.GALKA]    = {gear = {body = 12637, hand = 12758, leg = 12888, feet = 13009}, homeNation = xi.nation.BASTOK},
}

local startingNationInfo =
{
    [xi.nation.SANDORIA] = {ring = 13495, map = xi.ki.MAP_OF_THE_SAN_DORIA_AREA},
    [xi.nation.BASTOK]   = {ring = 13497, map = xi.ki.MAP_OF_THE_BASTOK_AREA},
    [xi.nation.WINDURST] = {ring = 13496, map = xi.ki.MAP_OF_THE_WINDURST_AREA},
}

local startingJobGear =
{
    [xi.job.WAR] = {16534},       -- onion sword
    [xi.job.MNK] = {13184},       -- white belt
    [xi.job.WHM] = {17068, 4608}, -- onion rod, scroll of cure
    [xi.job.BLM] = {17104, 4607}, -- onion staff, scroll of stone
    [xi.job.RDM] = {16482, 4606}, -- onion dagger, scroll of dia
    [xi.job.THF] = {16483},       -- onion knife
}

-----------------------------------
-- local functions
-----------------------------------

local function CharCreate(player)
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

    -- add nation- and race-specific ring
    if nation == raceInfo.homeNation and not player:hasItem(nationInfo.ring) then
        player:addItem(nationInfo.ring)
    end

    -- unlock advanced jobs
    if xi.settings.ADVANCED_JOB_LEVEL == 0 then
        for i = xi.job.PLD, xi.job.SCH do
            player:unlockJob(i)
        end
    end

    -- unlock subjob
    if xi.settings.SUBJOB_QUEST_LEVEL == 0 then
        player:unlockJob(0)
    end

    -- give all maps
    if xi.settings.ALL_MAPS == 1 then
        for i = xi.ki.MAP_OF_THE_SAN_DORIA_AREA, xi.ki.MAP_OF_DIO_ABDHALJS_GHELSBA do
            player:addKeyItem(i)
        end
        for i = xi.ki.MAP_OF_AL_ZAHBI, xi.ki.MAP_OF_OUTER_RAKAZNAR do
            player:addKeyItem(i)
        end
        for i = xi.ki.MAP_OF_RALA_WATERWAYS_U, xi.ki.MAP_OF_OUTER_RAKAZNAR_U do
            player:addKeyItem(i)
        end
        for i = xi.ki.MAP_OF_ESCHA_ZITAH, xi.ki.MAP_OF_REISENJIMA do
            player:addKeyItem(i)
        end
    end

    -- set initial level cap
    if xi.settings.INITIAL_LEVEL_CAP ~= 50 then
        player:setLevelCap(xi.settings.INITIAL_LEVEL_CAP)
    end

    -- increase starting inventory
    if xi.settings.START_INVENTORY > 30 then
        player:changeContainerSize(xi.inv.INVENTORY, xi.settings.START_INVENTORY - 30)
        player:changeContainerSize(xi.inv.MOGSATCHEL, xi.settings.START_INVENTORY - 30)
    end

    --[[
        For some intermittent reason m_ZoneList ends up empty on characters, which is
        possibly also why they lose key items.  When that happens, CharCreate will be run and
        they end up losing their gil to the code below.  Added a conditional to hopefully
        prevent that until the bug is fixed.  Used the if instead of addGil to prevent abuse
        on servers with very high values of START_GIL, I guess.
    --]]

    if player:getGil() < xi.settings.START_GIL then
       player:setGil(xi.settings.START_GIL)
    end

    player:addItem(536) -- adventurer coupon
    player:addTitle(xi.title.NEW_ADVENTURER)
    player:setCharVar("MoghouseExplication", 1) -- needs Moghouse intro
    player:setCharVar("spokeKindlix", 1) -- Kindlix introduction
    player:setCharVar("spokePyropox", 1) -- Pyropox introduction
    player:setCharVar("TutorialProgress", 1) -- Has not started tutorial
    player:setCharVar("EinherjarIntro", 1) -- Has not seen Einherjar intro
    player:setNewPlayer(true) -- apply new player flag
end

-----------------------------------
-- public functions
-----------------------------------

xi = xi or {}
xi.player = {}

-- called by core after a player logs into the server or zones
xi.player.onGameIn = function(player, firstLogin, zoning)
    if not zoning then
        -- things checked ONLY during logon go here
        if firstLogin then
            CharCreate(player)
        end
    else
        -- things checked ONLY during zone in go here
    end

    -- apply mods from gearsets (scripts/globals/gear_sets.lua)
    checkForGearSet(player)

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

    -- Login Campaign rewards points once daily
    player:timer(2000, function (player) tpz.events.loginCampaign.onGameIn(player) end) -- Hacky recommendation by Teo.
end

xi.player.onPlayerLevelUp = function(player)
end

xi.player.onPlayerLevelDown = function(player)
end

xi.player.onPlayerEmote = function(player, emoteId)
    if emoteId == xi.emote.CHEER and player:hasStatusEffect(xi.effect.FULL_SPEED_AHEAD) then
        xi.fsa.onCheer(player)
    end
end

return xi.player
