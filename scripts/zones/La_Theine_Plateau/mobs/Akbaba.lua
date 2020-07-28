-----------------------------------
-- Area: La Theine Plateau
--  Mob: Akbaba
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 69, 2, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end
