-----------------------------------
-- Area: Jugner Forest
--   NM: Meteormauler Zhagtegg
-----------------------------------
mixins = { require('scripts/mixins/job_special'), require('scripts/mixins/rotz_bodyguarded_nm') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -232.300, y = -8.180, z = -571.660 },
    { x = -229.100, y = -7.650, z = -556.170 },
    { x = -218.120, y = -8.000, z = -566.110 },
    { x = -217.610, y = -8.570, z = -551.960 },
    { x = -205.580, y = -7.810, z = -553.790 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(75600 + math.random(0, 600))
end

-- all body guard functionality in the rotz_bodyguarded_nm mixin

entity.onMobSpawn = function(mob)
    -- retail captures show these mods are not dependent on region control
    mob:setMod(xi.mod.UDMGPHYS, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(75600 + math.random(0, 600)) -- 21 hours, 10 minute window
end

return entity
