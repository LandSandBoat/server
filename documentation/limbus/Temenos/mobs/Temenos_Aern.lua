-----------------------------------
-- Area: Temenos Northern Tower
--  Mob: Temenos Aern
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Aerns_Wynav')
    xi.pet.setMobPet(mob, 1, 'Aerns_Euvhi')
    xi.pet.setMobPet(mob, 1, 'Aerns_Elemental')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
