-----------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Gigas Flesher
-----------------------------------
mixins = { require('scripts/mixins/pet_resummon') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Gigass_Tiger')
end

return entity
