-----------------------------------
-- Area: King Ranperres Tomb
--   NM: Cemetery Cherry
-- !pos 33.000 0.500 -287.000 190
-----------------------------------
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("wasKilled", 0)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:setLocalVar("wasKilled", 1)
    player:addTitle(xi.title.MON_CHERRY)
end

entity.onMobDespawn = function(mob)
    local cemCherry = mob:getID()
    local respawnTime = 75600 -- If something breaks default to 21 hours

    UpdateNMSpawnPoint(mob:getID())
    GetMobByID(cemCherry):setLocalVar("[POP]Cemetery_Cherry", 0)

    -- Set respawn persistence of cherry saplings
    if mob:getLocalVar("wasKilled") == 1 then
        respawnTime = math.random(75600, 86400) -- 21 to 24 hours
    else
        respawnTime = math.random(1800, 3600) -- 30 to 60 minutes if despawned
    end

    for offset = 1, 6 do
        xi.mob.nmTODPersist(GetMobByID(cemCherry - offset), respawnTime)
        DisallowRespawn(cemCherry - offset, false)
    end

    for offsetTwo = 1, 2 do
        xi.mob.nmTODPersist(GetMobByID(cemCherry + offsetTwo), respawnTime)
        DisallowRespawn(cemCherry + offsetTwo, false)
    end
end

return entity
