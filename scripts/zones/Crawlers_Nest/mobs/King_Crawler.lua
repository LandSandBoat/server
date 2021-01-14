-----------------------------------
-- Area: Crawlers' Nest
--  Mob: King Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 693, 1, tpz.regime.type.GROUNDS)
end

return entity
