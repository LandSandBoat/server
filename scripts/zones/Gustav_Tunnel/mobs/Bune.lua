-----------------------------------
-- Area: Gustav Tunnel
--   NM: Bune
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- Set Bune's spawnpoint and respawn time (21-24 hours)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400))
end

return entity
