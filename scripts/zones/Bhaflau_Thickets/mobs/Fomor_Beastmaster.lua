-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Fomor Beastmaster
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Fomors_Bats')
end

return entity
