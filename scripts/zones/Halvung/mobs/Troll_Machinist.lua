-----------------------------------
-- Area: Halvung
--  Mob: Troll Machinist
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Trolls_Automaton')
end

return entity
