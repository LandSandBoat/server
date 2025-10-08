-----------------------------------
-- Area: East Ronfaure [S]
--  Mob: Goblin Patrolman
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Ladybug')
end

return entity
