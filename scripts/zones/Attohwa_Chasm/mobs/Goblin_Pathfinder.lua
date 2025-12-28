-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Goblin Pathfinder
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Gallinipper')
end

return entity
