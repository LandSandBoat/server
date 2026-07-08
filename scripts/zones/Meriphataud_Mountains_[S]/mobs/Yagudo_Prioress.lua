-----------------------------------
-- Area: Meriphataud Mountains [S]
--  Mob: Yagudo Prioress
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Yagudos_Elemental')
end

return entity
