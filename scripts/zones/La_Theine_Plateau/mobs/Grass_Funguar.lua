-----------------------------------
-- Area: La Theine Plateau
--  Mob: Grass Funguar
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 6, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 71, 2, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end
