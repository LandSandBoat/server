-----------------------------------
-- Area: Bibiki Bay
--   NM: Goblin Pathfinder
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Rarab')
end

return entity
