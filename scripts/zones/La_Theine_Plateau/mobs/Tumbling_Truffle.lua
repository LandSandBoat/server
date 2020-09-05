-----------------------------------
-- Area: La Theine Plateau
--  Mob: Tumbling Truffle
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
require("scripts/quests/tutorial")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 154)
    tpz.regime.checkRegime(player, mob, 71, 2, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end
