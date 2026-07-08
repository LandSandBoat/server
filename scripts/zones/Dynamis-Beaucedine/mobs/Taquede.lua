-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Taquede
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Taquedes_Wyvern')
end

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

return entity
