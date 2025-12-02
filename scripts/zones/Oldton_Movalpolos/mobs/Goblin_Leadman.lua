-----------------------------------
-- Area: Oldton Movalpolos
--  Mob: Goblin Leadman
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Bat')
end

return entity
