-----------------------------------
-- Area: Newton Movalpolos
--  Mob: Goblin Headman
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Bat')
end

return entity
