-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Soldier Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 688, 1, xi.regime.type.GROUNDS)
end

return entity
