-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Knight Crawler
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 692, 2, xi.regime.type.GROUNDS)
end

return entity
