-----------------------------------
-- Area: East Ronfaure [S]
--  Mob: Goblin Patrolman
-----------------------------------
mixins = { require('scripts/mixins/pet_resummon') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Ladybug')
end

return entity
