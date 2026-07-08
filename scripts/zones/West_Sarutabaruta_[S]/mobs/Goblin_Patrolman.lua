-----------------------------------
-- Area: West Sarutabaruta [S]
--   NM: Goblin Patrolman
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Rarab')
end

return entity
