-----------------------------------
-- Area: Buburimu Peninsula (118)
--  Mob: Shoal Pugil
-- Note: PH for Buburimboo
-----------------------------------
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 62, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BUBURIMBOO_PH, 5, math.random(3600, 7200)) -- 1 to 2 hours
end
