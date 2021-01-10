-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Knight Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 692, 2, tpz.regime.type.GROUNDS)
end

return entity
