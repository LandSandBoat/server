-----------------------------------
-- Area: Al Zahbi
--  Mob: Assault Draugar
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Draugars_Wyvern')
end

return entity
