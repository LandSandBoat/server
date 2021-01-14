-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Death Jacket
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 687, 2, tpz.regime.type.GROUNDS)
end

return entity
