-----------------------------------
-- Area: Tahrongi Canyon
--  Mob: Canyon Rarab
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 94, 1, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end
