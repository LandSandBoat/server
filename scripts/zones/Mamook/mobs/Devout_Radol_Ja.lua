-----------------------------------
-- Area: Mamook
--   NM: Devout Radol Ja
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(259200, 432000)) -- 3 to 5 days
end

return entity
