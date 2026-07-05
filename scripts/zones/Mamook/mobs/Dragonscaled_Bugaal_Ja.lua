-----------------------------------
-- Area: Mamook
--   NM: Dragonscaled Bugaal Ja
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Tyrannobugard')
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(100800, 259200)) -- 28 to 72 hours
end

return entity
