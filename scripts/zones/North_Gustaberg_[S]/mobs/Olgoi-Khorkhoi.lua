-----------------------------------
-- Area: North Gustaberg [S]
--   NM: Olgoi-Khorkhoi
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 499)
end

entity.onMobDespawn = function(mob)
    -- Sets to respawn between 90 to 120 minutes
    -- UpdateNMSpawnPoint(mob:getID()) TODO: need rows in nm_spawn_points.sql
    mob:setRespawnTime(math.random(5400, 7200))
end

return entity
