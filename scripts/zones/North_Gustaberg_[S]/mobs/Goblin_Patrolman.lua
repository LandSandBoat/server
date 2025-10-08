-----------------------------------
-- Area: North Gustaberg [S]
--   NM: Goblin Patrolman
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Bee')
end

return entity
