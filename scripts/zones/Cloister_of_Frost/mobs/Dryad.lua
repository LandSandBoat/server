-----------------------------------
-- Area: Cloister of Frost
--  Mob: Dryad
-- Involved in Quest: Class Reunion
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
end

return entity
