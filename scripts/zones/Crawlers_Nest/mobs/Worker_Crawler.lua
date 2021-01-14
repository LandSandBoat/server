-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Worker Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 687, 1, tpz.regime.type.GROUNDS)
end

return entity
