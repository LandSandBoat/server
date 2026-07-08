-----------------------------------
-- Area: West Sarutabaruta [S]
--   NM: Yagudo Mendicant
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Yagudos_Elemental')
end

return entity
