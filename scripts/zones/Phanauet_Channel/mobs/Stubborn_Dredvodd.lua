-----------------------------------
-- Area: Phanauet Channel (1)
--   NM: Stubborn Dredvodd
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Orcs_Wyvern')
end

return entity
