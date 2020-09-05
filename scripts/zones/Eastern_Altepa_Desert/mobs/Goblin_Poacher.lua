-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Goblin Poacher
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 113, 1, tpz.regime.type.FIELDS)
end
