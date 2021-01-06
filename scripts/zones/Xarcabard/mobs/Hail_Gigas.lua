-----------------------------------
-- Area: Xarcabard
--  Mob: Hail Gigas
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 54, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 55, 2, tpz.regime.type.FIELDS)
end

return entity
