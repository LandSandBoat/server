-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Goblin Trader
-----------------------------------
mixins = { require('scripts/mixins/pet_resummon') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Spider')
end

return entity
