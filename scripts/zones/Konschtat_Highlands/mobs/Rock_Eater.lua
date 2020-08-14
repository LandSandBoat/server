-----------------------------------
-- Area: Konschtat Highlands
--  Mob: Rock Eater
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 20, 1, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end
