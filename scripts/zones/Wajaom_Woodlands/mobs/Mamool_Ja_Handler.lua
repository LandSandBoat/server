-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Mamool Ja Handler
--  Besieged
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.besieged.onMobInitialize(mob)
    xi.pet.setMobPet(mob, 1, 'Mamool_Jas_Lizard')
end

entity.onMobSpawn = function(mob)
    xi.besieged.onMobSpawn(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.besieged.onMobDeath(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.besieged.onMobDespawn(mob)
end

return entity
