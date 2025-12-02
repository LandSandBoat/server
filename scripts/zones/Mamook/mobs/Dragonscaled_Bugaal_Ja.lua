-----------------------------------
-- Area: Mamook
--   NM: Dragonscaled Bugaal Ja
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Tyrannobugard')
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(100800, 259200)) -- 28 to 72 hours
end

return entity
