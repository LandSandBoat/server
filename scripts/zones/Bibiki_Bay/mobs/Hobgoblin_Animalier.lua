-----------------------------------
-- Area: Bibiki Bay
--   NM: Hobgoblin Animalier
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Rarab')
end

return entity
