-----------------------------------
-- Area: The Sanctuary of ZiTah
--  Mob: Goblin Trader
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Leech')
end

return entity
