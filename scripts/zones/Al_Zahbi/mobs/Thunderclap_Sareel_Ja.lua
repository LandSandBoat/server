-----------------------------------
-- Area: Al Zahbi
--  Mob: Thunderclap Sareel Ja
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Thunderbolt_Piraal_Ja')
end

return entity
