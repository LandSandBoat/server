-----------------------------------
-- Area: La Theine Plateau
--  Mob: Poison Funguar
-----------------------------------
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
require("scripts/quests/tutorial")

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 71, 2, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.TUMBLING_TRUFFLE_PH, 5, math.random(3600, 28800)) -- 1 to 8 hours
end
