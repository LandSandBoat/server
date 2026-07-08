-----------------------------------
-- Area: Mamook
--   NM: Devout Radol Ja
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(259200, 432000)) -- 3 to 5 days
end

return entity
