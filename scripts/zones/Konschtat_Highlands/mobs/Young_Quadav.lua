-----------------------------------
-- Area: Konschtat Highlands
--  Mob: Young Quadav
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 83, 1, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end
