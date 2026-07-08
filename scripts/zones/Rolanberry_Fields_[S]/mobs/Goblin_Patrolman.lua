-----------------------------------
-- Area: Rolanberry Fields [S]
--  Mob: Goblin Patrolman
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Crawler')
    xi.pet.setMobPet(mob, 2, 'Goblins_Crawler')
    xi.pet.setMobPet(mob, 3, 'Goblins_Crawler')
end

return entity
