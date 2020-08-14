-----------------------------------
-- Area: Konschtat Highlands
--  Mob: Strolling Sapling
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 81, 1, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end
