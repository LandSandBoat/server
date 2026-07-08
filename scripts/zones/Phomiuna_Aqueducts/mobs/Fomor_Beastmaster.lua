-----------------------------------
-- Area: Phomiuna_Aqueducts
--  Mob: Fomor Beastmaster
-----------------------------------
mixins = { require('scripts/mixins/fomor_hate') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Fomors_Bat')
end

return entity
