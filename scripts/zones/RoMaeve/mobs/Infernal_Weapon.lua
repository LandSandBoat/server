-----------------------------------
-- Area: RoMaeve
--  Mob: Infernal Weapon
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 123, 1, tpz.regime.type.FIELDS)
end
