-----------------------------------
-- Area: Beaucedine Glacier
--  Mob: Goblin Shaman
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 46, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 49, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 50, 2, tpz.regime.type.FIELDS)
end
