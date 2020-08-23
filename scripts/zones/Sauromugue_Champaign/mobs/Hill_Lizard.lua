-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Hill Lizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 40, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BANSHE_PH, 10, 3600) -- 1 hour
end
