-----------------------------------
-- Area: Beaucedine Glacier
--  Mob: Rime Gigas
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 50, 1, tpz.regime.type.FIELDS)
end
