-----------------------------------
-- Area: Castle Zvahl Baileys (161)
--  Mob: Goblin Trader
-----------------------------------
mixins = { require('scripts/mixins/pet_resummon') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Bats')
end

return entity
