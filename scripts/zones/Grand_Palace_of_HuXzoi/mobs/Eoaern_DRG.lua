-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  Mob: Eo'aern
-----------------------------------
mixins = { require('scripts/mixins/families/aern') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Aerns_Wynav')
    xi.pet.setMobPet(mob, 2, 'Aerns_Wynav')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
