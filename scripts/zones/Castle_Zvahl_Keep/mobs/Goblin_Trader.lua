-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Goblin Trader
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Bat')
end

return entity
