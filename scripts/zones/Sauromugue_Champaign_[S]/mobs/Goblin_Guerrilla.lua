-----------------------------------
-- Area: Sauromogue Champaign [S]
--  Mob: Goblin Guerrilla
-----------------------------------
mixins = { require('scripts/mixins/pet_resummon') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Beetle')
end

return entity
