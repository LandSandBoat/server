-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Over Weapon
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 705, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 708, 1, tpz.regime.type.GROUNDS)
end
