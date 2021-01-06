-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Rumble Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 691, 1, tpz.regime.type.GROUNDS)
end

return entity
