-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Dark Dragon
-- Mission 2-3 BCNM Fight
-----------------------------------
local entity = {}

require("scripts/globals/titles")
require("scripts/globals/status")

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.DARK_DRAGON_SLAYER)
end

return entity
