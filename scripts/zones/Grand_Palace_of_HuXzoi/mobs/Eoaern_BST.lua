-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  Mob: Eo'aern
-----------------------------------
mixins = { require('scripts/mixins/families/aern') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 2, 'Aerns_Euvhi')
    xi.pet.setMobPet(mob, 3, 'Aerns_Euvhi')
    xi.pet.setMobPet(mob, 4, 'Aerns_Euvhi')
end

return entity
