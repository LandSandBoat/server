-----------------------------------
-- Area: Pashhow Marshlands [S]
--  Mob: Goblin Guerrilla
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Dragonfly')
    xi.pet.setMobPet(mob, 2, 'Goblins_Dragonfly')
end

return entity
