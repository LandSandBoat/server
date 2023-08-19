-----------------------------------
-- Area: Crawlers' Nest
--  Mob: King Crawler
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 693, 1, xi.regime.type.GROUNDS)
end

return entity
