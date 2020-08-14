-----------------------------------
-- Area: Tahrongi Canyon
--  Mob: Killer Bee
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 30, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 95, 2, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end
