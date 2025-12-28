-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Troll Speculator
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Trolls_Automaton')
end

return entity
