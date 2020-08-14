-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Labyrinth Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 763, 2, tpz.regime.type.GROUNDS)
end
