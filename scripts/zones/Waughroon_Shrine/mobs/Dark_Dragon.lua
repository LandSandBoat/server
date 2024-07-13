-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Dark Dragon
-- Mission 2-3 BCNM Fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN_BITMASK, xi.drawin.NORMAL)
    mob:setMobMod(xi.mobMod.DRAW_IN_TRIGGER_DIST, 25)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.DARK_DRAGON_SLAYER)
end

return entity
