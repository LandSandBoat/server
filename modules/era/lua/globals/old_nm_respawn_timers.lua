-----------------------------------
-- Old NM Respawn Timers
-- Date : 2013-11-04 (One day prior to the November 5, 2013 version update)
-- Reverts the respawn timers of multiple notorious monsters to their
-- values prior to the November 5, 2013 version update, which reduced
-- them across the original areas:
-- https://forum.square-enix.com/ffxi/threads/38100
-- Windows are persisted across server restarts via server variables.
--
--   Argus / Leech King (Maze of Shakhrami) : 18 to 30 hours, shared spawn pair
--   Roc (Sauromugue Champaign)             : 21 to 24 hours
--   Morbolger (Ordelle's Caves)            : 21 to 24 hours
--   Juggler Hecatomb (Gusgen Mines)        : 21 to 24 hours
--   Capricious Cassie (Fei'Yin)            : 21 to 24 hours
--   Dosetsu Tree (Qufim Island)            : 21 to 24 hours, still thunder weather only
--   Bloodsucker (Bostaunieux Oubliette)    : 72 hours exactly
--   N/E/W/S Shadow (Fei'Yin)               : 16 hour lottery cooldown from Specter PHs
-----------------------------------
require('modules/module_utils')
-----------------------------------

local moduleName = 'era_old_nm_respawn_timers'

if xi.module.isContentEnabled('SOA') then
    return { name = moduleName }
end

local shakhramiID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
local feiyinID    = zones[xi.zone.FEIYIN]
local bostauID    = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
local m = Module:new(moduleName)

-----------------------------------
-- Simple timed NMs
-- On despawn: roll a new window, persist it. On zone init: restore the
-- remaining window, or spawn the NM if it came due during downtime.
-----------------------------------
local timedNMs =
{
    -- { zone folder name, mob file name }
    { 'Sauromugue_Champaign', 'Roc'               },
    { 'Ordelles_Caves',       'Morbolger'         },
    { 'Gusgen_Mines',         'Juggler_Hecatomb'  },
    { 'FeiYin',               'Capricious_Cassie' },
}

for _, entry in pairs(timedNMs) do
    local zoneName = entry[1]
    local mobName  = entry[2]
    local varName  = '[Respawn]' .. mobName

    m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobDespawn', zoneName, mobName), function(mob)
        if mob:getLocalVar('[Respawn]bootSync') == 1 then
            -- Forced back down by zone init below to restore the saved window; keep it
            mob:setLocalVar('[Respawn]bootSync', 0)
            return
        end

        super(mob)

        local respawn = math.randomInt(75600, 86400) -- 21 to 24 hours
        mob:setRespawnTime(respawn)
        SetServerVariable(varName, GetSystemTime() + respawn)
    end)

    m:addOverride(string.format('xi.zones.%s.Zone.onInitialize', zoneName), function(zone)
        super(zone)

        local mob = zone:queryEntitiesByName(mobName)[1]
        if not mob then
            return
        end

        local respawn = GetServerVariable(varName)
        if respawn == 0 and not mob:isSpawned() then
            -- First boot with the module: seed a fresh window instead of popping immediately
            respawn = GetSystemTime() + math.randomInt(75600, 86400) -- 21 to 24 hours
            SetServerVariable(varName, respawn)
        end

        if GetSystemTime() < respawn then
            xi.mob.updateNMSpawnPoint(mob)
            mob:setRespawnTime(respawn - GetSystemTime())

            if mob:isSpawned() then
                -- Engine popped this spawntype 0 mob at boot mid-window
                mob:setLocalVar('[Respawn]bootSync', 1)
                DespawnMob(mob:getID())
            end
        elseif not mob:isSpawned() then
            -- Clear any respawn the mob script registered at load, or the
            -- engine will pop the NM again on top of this spawn when it comes due
            mob:setRespawnTime(0)
            SpawnMob(mob:getID())
        end
    end)
end

-----------------------------------
-- Argus / Leech King
-- Either NM despawning rolls 50/50 for which of the two comes back,
-- 18 to 30 hours later (base scripts use the same roll at 1 to 2 hours).
-----------------------------------
local function scheduleLeechPair(nextId, seconds)
    local otherId = nextId == shakhramiID.mob.ARGUS and shakhramiID.mob.LEECH_KING or shakhramiID.mob.ARGUS

    DisallowRespawn(otherId, true)
    DisallowRespawn(nextId, false)
    xi.mob.updateNMSpawnPoint(nextId)
    GetMobByID(nextId):setRespawnTime(seconds)
    SetServerVariable('[Respawn]LeechKingArgus_Mob', nextId)
    SetServerVariable('[Respawn]LeechKingArgus_Time', GetSystemTime() + seconds)
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

    -- The base zone script in super just picked one of the pair and
    -- scheduled it to pop 15 minutes to 2 hours from now. Wipe that from
    -- both mobs before applying the saved schedule, or the engine will
    -- still pop the base pick later on its own timer.
    GetMobByID(shakhramiID.mob.ARGUS):setRespawnTime(0)
    GetMobByID(shakhramiID.mob.LEECH_KING):setRespawnTime(0)

    local nextId   = GetServerVariable('[Respawn]LeechKingArgus_Mob')
    local nextTime = GetServerVariable('[Respawn]LeechKingArgus_Time')

    if nextId == 0 then
        -- First boot with the module: seed a fresh roll and window
        scheduleLeechPair(
            math.randomInt(1, 100) <= 50 and shakhramiID.mob.ARGUS or shakhramiID.mob.LEECH_KING,
            math.randomInt(64800, 108000)) -- 18 to 30 hours
    elseif GetSystemTime() < nextTime then
        scheduleLeechPair(nextId, nextTime - GetSystemTime())
    else
        -- Came due during downtime
        DisallowRespawn(nextId == shakhramiID.mob.ARGUS and shakhramiID.mob.LEECH_KING or shakhramiID.mob.ARGUS, true)
        xi.mob.updateNMSpawnPoint(nextId)
        SpawnMob(nextId)
    end
end)

-----------------------------------
-- Dosetsu Tree
-- Window widened from 1-2 hours to 21-24 hours. Qufim's Zone.lua still
-- gates the actual spawn behind thunder weather via the 'respawn' local var.
-- Depopping without being killed counts the same as a kill: the window
-- rolls on every despawn, weather included.
-----------------------------------
m:addOverride('xi.zones.Qufim_Island.mobs.Dosetsu_Tree.onMobDespawn', function(mob)
    local respawn = GetSystemTime() + math.randomInt(75600, 86400) -- 21 to 24 hours
    mob:setLocalVar('respawn', respawn)
    SetServerVariable('[Respawn]Dosetsu_Tree', respawn)
end)

m:addOverride('xi.zones.Qufim_Island.Zone.onInitialize', function(zone)
    super(zone)

    local tree = zone:queryEntitiesByName('Dosetsu_Tree')[1]
    if not tree then
        return
    end

    -- Local vars are lost on restart; restore the pop window.
    tree:setLocalVar('respawn', GetServerVariable('[Respawn]Dosetsu_Tree'))
end)

-----------------------------------
-- N/E/W/S Shadows
-- Lottery cooldowns set to a flat 16 hours for all four (base rolls
-- 1 to 2 hours). Chance stays at the base 10 percent and the Specter
-- PH mechanics are unchanged.
-- NOTE: lottery cooldowns live in a local var and do not survive restarts;
-- this matches base behavior for all lottery NMs.
-----------------------------------
m:addOverride('xi.zones.FeiYin.mobs.Specter.onMobDespawn', function(mob)
    xi.mob.phOnDespawn(mob, feiyinID.mob.NORTHERN_SHADOW, 10, 57600) -- 16 hours
    xi.mob.phOnDespawn(mob, feiyinID.mob.EASTERN_SHADOW, 10, 57600) -- 16 hours
    xi.mob.phOnDespawn(mob, feiyinID.mob.WESTERN_SHADOW, 10, 57600) -- 16 hours
    xi.mob.phOnDespawn(mob, feiyinID.mob.SOUTHERN_SHADOW, 10, 57600) -- 16 hours
end)

-----------------------------------
-- Bloodsucker
-- Window widened from 1 hour to 72 hours, persisted.
-----------------------------------
m:addOverride('xi.zones.Bostaunieux_Oubliette.mobs.Bloodsucker_NM.onMobDespawn', function(mob)
    super(mob)

    mob:setRespawnTime(259200) -- 72 hours
    SetServerVariable('[Respawn]Bloodsucker_NM', GetSystemTime() + 259200)
end)

m:addOverride('xi.zones.Bostaunieux_Oubliette.Zone.onInitialize', function(zone)
    super(zone)

    local bloodsucker = GetMobByID(bostauID.mob.BLOODSUCKER)
    if not bloodsucker then
        return
    end

    local respawn = GetServerVariable('[Respawn]Bloodsucker_NM')
    if GetSystemTime() < respawn then
        -- Replaces the 1 hour respawn his script registered at load
        bloodsucker:setRespawnTime(respawn - GetSystemTime())
    elseif not bloodsucker:isSpawned() then
        -- Clear the 1 hour respawn his script registered at load, or the
        -- engine pops him again an hour after boot
        bloodsucker:setRespawnTime(0)
        SpawnMob(bostauID.mob.BLOODSUCKER)
    end
end)

return m
