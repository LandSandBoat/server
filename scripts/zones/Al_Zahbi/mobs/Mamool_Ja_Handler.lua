-----------------------------------
-- Area: Al Zahbi
--  Mob: Mamool Ja Handler
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Mamool_Jas_Lizard')
end

return entity
