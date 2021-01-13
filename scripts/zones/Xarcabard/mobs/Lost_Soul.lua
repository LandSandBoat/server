-----------------------------------
-- Area: Xarcabard
--  Mob: Lost Soul
-- Note: PH for Timeworn Warrior
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 51, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 52, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 53, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 54, 3, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.TIMEWORN_WARRIOR_PH, 5, 5400) -- 90 minutes
end

return entity
