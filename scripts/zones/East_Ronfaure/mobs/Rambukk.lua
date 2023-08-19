-----------------------------------
-- Area: East Ronfaure
--  Mob: Rambukk
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 152)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(900, 3600)) -- 15 min to 1 hour
end

return entity
