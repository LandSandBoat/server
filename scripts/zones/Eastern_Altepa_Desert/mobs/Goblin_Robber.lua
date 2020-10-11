-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Goblin Robber
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 113, 2, tpz.regime.type.FIELDS)
end
