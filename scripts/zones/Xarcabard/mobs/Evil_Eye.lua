-----------------------------------
-- Area: Xarcabard
--  Mob: Evil Eye
-- Note: PH for Shadow Eye
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 53, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 54, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 55, 3, tpz.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SHADOW_EYE_PH, 5, 3600) -- 1 hour
end

return entity
