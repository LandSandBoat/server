-----------------------------------
-- Area: Xarcabard
--  Mob: Demon Wizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 55, 1, tpz.regime.type.FIELDS)
end

return entity
