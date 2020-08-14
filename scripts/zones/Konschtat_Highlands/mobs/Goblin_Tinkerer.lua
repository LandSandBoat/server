-----------------------------------
-- Area: Konschtat Highlands
--  Mob: Goblin Tinkerer
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 84, 2, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end
