-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Wendigo
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

return entity
