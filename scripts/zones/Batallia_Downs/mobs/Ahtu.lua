-----------------------------------
-- Area: Batallia Downs (105)
--  Mob: Ahtu
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- Set Ahtu's spawnpoint and respawn time (2-4 hours)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(7200, 14400))
end

return entity
