-----------------------------------
-- Area: Lufaise Meadows (24)
--  Mob: Splinterspine Grukjuk
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
