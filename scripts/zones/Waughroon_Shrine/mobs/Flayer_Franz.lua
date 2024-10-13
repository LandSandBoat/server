-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Flayer Franz
-- BCNM: The Worm's Turn
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN_BITMASK, xi.drawin.NORMAL)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
