-----------------------------------
-- Area: Konschtat Highlands
--  Mob: Huge Wasp
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 81, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 82, 1, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end
