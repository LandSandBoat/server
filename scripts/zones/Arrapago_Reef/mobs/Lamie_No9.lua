-----------------------------------
-- Area: Arrapago Reef
--  Mob: Lamie No. 9
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -228.367, y = -4.690, z = 342.671 }
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Lamias_Avatar')
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(208800, 216000)) -- 58-60 hours
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(252000, 259200)) -- 70-72 hours
end

return entity
