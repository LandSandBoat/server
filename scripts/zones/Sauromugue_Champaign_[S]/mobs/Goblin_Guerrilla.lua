-----------------------------------
-- Area: Sauromogue Champaign [S]
--  Mob: Goblin Guerrilla
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Beetle')
end

return entity
