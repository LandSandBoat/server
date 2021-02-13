-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Vespo
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 693, 2, tpz.regime.type.GROUNDS)
end

return entity
