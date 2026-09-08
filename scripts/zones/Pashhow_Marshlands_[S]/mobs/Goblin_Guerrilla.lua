-----------------------------------
-- Area: Pashhow Marshlands [S]
--  Mob: Goblin Guerrilla
-----------------------------------
mixins = { require('scripts/mixins/pet_resummon') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Dragonfly')
    xi.pet.setMobPet(mob, 2, 'Goblins_Dragonfly')
end

return entity
