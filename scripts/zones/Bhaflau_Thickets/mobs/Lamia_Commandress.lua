-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Lamia Commandress
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Lamias_Elemental')
end

return entity
