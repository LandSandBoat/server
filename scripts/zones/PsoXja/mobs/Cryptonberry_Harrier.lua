-----------------------------------
-- Area: Pso'Xja
--  Mob: Cryptonberry Harrier
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Tonberrys_Elemental')
end

return entity
