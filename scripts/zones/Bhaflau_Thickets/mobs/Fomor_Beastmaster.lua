-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Fomor Beastmaster
-----------------------------------
mixins = { require('scripts/mixins/pet_resummon') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Fomors_Bats')
end

return entity
