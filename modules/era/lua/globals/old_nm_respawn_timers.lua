-----------------------------------
-- Old NM Respawn Timers
-- Date : 2013-11-04 (One day prior to the November 5, 2013 version update)
-- The November 5, 2013 version update shortened NM respawn timers across the
-- original areas. This module puts the old timers back.
--
-- Source: https://forum.square-enix.com/ffxi/threads/38100
--
-- Each window is set when the zone loads. A restart starts it over.
-- Base spawns Juggler Hecatomb, Manipulator and Atkorkamuy at load. This
-- module holds them until their window ends.
--
--   Argus / Leech King (Maze of Shakhrami) : 18 to 30 hours, shared spawn pair
--   Roc (Sauromugue Champaign)             : 21 to 24 hours
--   Morbolger (Ordelle's Caves)            : 21 to 24 hours
--   Juggler Hecatomb (Gusgen Mines)        : 21 to 24 hours
--   Capricious Cassie (Fei'Yin)            : 21 to 24 hours
--   Simurgh (Rolanberry Fields)            : 21 to 24 hours
--   Manipulator (Temple of Uggalepih)      : 2 hours
--   Atkorkamuy (Qufim Island)              : 2 hours, only with WotG content on
--   Bloodsucker (Bostaunieux Oubliette)    : 72 hours exactly
--   Dosetsu Tree (Qufim Island)            : 21 to 24 hours, still thunder weather only
--   N/E/W/S Shadow (Fei'Yin)               : 16 hour lottery cooldown from Specter PHs
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_old_nm_respawn_timers', xi.pre(xi.expansion.SOA))

local shakhramiID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
local feiyinID    = zones[xi.zone.FEIYIN]

-----------------------------------
-- Simple timed NMs
-- Each override registers the window during initialize. The boot spawn pass
-- skips a mob with a pending respawn, so the NM stays down.
-- This table handles normal and scripted spawn types only. The engine blocks
-- lottery and windowed mobs after initialize.
-----------------------------------
local timedNMs =
{
    -- { zone folder name, mob file name, min respawn, max respawn }
    { 'Sauromugue_Champaign',  'Roc',                75600,  86400 }, -- 21 to 24 hours
    { 'Ordelles_Caves',        'Morbolger',          75600,  86400 }, -- 21 to 24 hours
    { 'Gusgen_Mines',          'Juggler_Hecatomb',   75600,  86400 }, -- 21 to 24 hours
    { 'FeiYin',                'Capricious_Cassie',  75600,  86400 }, -- 21 to 24 hours
    { 'Rolanberry_Fields',     'Simurgh',            75600,  86400 }, -- 21 to 24 hours
    { 'Temple_of_Uggalepih',   'Manipulator',         7200,   7200 }, -- 2 hours
    { 'Bostaunieux_Oubliette', 'Bloodsucker_NM',    259200, 259200 }, -- 72 hours
}

-- Atkorkamuy is WotG content. His script never loads when that content is
-- off. The override would error at every boot.
if not xi.pre(xi.expansion.WOTG) then
    table.insert(timedNMs, { 'Qufim_Island', 'Atkorkamuy', 7200, 7200 }) -- 2 hours
end

for _, entry in pairs(timedNMs) do
    local zoneName   = entry[1]
    local mobName    = entry[2]
    local respawnMin = entry[3]
    local respawnMax = entry[4]

    m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobInitialize', zoneName, mobName), function(mob)
        super(mob)

        -- Base only rolls a spawn point for Juggler Hecatomb and Atkorkamuy
        -- on despawn. Roll one here so their first pop is not a fixed spot.
        xi.mob.updateNMSpawnPoint(mob)
        mob:setRespawnTime(math.randomInt(respawnMin, respawnMax))
    end)

    m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobDespawn', zoneName, mobName), function(mob)
        super(mob)

        mob:setRespawnTime(math.randomInt(respawnMin, respawnMax))
    end)
end

-----------------------------------
-- Argus / Leech King
-- Either NM despawning rolls 50/50 for which one comes back, 18 to 30 hours
-- later. Base uses the same roll at 1 to 2 hours.
-----------------------------------
local function scheduleLeechPair(nextId, seconds)
    local otherId = nextId == shakhramiID.mob.ARGUS and shakhramiID.mob.LEECH_KING or shakhramiID.mob.ARGUS

    DisallowRespawn(otherId, true)
    DisallowRespawn(nextId, false)
    xi.mob.updateNMSpawnPoint(nextId)
    GetMobByID(nextId):setRespawnTime(seconds)
end

m:addOverride('xi.zones.Maze_of_Shakhrami.mobs.Argus.onMobDespawn', function(mob)
    scheduleLeechPair(
        math.randomInt(1, 100) <= 50 and shakhramiID.mob.ARGUS or shakhramiID.mob.LEECH_KING,
        math.randomInt(64800, 108000)) -- 18 to 30 hours
end)

m:addOverride('xi.zones.Maze_of_Shakhrami.mobs.Leech_King.onMobDespawn', function(mob)
    scheduleLeechPair(
        math.randomInt(1, 100) <= 50 and shakhramiID.mob.ARGUS or shakhramiID.mob.LEECH_KING,
        math.randomInt(64800, 108000)) -- 18 to 30 hours
end)

m:addOverride('xi.zones.Maze_of_Shakhrami.Zone.onInitialize', function(zone)
    super(zone)

    -- Super picked one of the pair and scheduled it 15 minutes to 2 hours
    -- out. Clear both timers first. The engine pops the base pick otherwise.
    GetMobByID(shakhramiID.mob.ARGUS):setRespawnTime(0)
    GetMobByID(shakhramiID.mob.LEECH_KING):setRespawnTime(0)

    scheduleLeechPair(
        math.randomInt(1, 100) <= 50 and shakhramiID.mob.ARGUS or shakhramiID.mob.LEECH_KING,
        math.randomInt(64800, 108000)) -- 18 to 30 hours
end)

-----------------------------------
-- Dosetsu Tree
-- Window widened from 1 to 2 hours to 21 to 24 hours. Qufim's Zone.lua
-- still gates the spawn on thunder weather through the 'respawn' local var.
-- The window rolls on every despawn. A weather depop counts as a kill.
-----------------------------------
m:addOverride('xi.zones.Qufim_Island.mobs.Dosetsu_Tree.onMobInitialize', function(mob)
    super(mob)

    mob:setLocalVar('respawn', GetSystemTime() + math.randomInt(75600, 86400)) -- 21 to 24 hours
end)

m:addOverride('xi.zones.Qufim_Island.mobs.Dosetsu_Tree.onMobDespawn', function(mob)
    mob:setLocalVar('respawn', GetSystemTime() + math.randomInt(75600, 86400)) -- 21 to 24 hours
end)

-----------------------------------
-- N/E/W/S Shadows
-- All four take a flat 16 hour cooldown. Base rolls 1 to 2 hours. The 10
-- percent chance and the Specter placeholder mechanics are unchanged.
-- The cooldown lives in a local var and resets with the server, the same as
-- every other lottery NM.
-----------------------------------
m:addOverride('xi.zones.FeiYin.mobs.Specter.onMobDespawn', function(mob)
    xi.mob.phOnDespawn(mob, feiyinID.mob.NORTHERN_SHADOW, 10, 57600) -- 16 hours
    xi.mob.phOnDespawn(mob, feiyinID.mob.EASTERN_SHADOW, 10, 57600) -- 16 hours
    xi.mob.phOnDespawn(mob, feiyinID.mob.WESTERN_SHADOW, 10, 57600) -- 16 hours
    xi.mob.phOnDespawn(mob, feiyinID.mob.SOUTHERN_SHADOW, 10, 57600) -- 16 hours
end)
