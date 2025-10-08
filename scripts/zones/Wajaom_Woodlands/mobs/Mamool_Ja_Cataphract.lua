-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Mamool Ja Cataphract
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Mamool_Jas_Wyvern')
end

return entity
