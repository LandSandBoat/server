-----------------------------------
-- Area: North Gustaberg
--  Mob: Maneating Hornet
-- Note: Place Holder For Stinging Sophie
-----------------------------------
local ID = require("scripts/zones/North_Gustaberg/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 17, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.STINGING_SOPHIE_PH, 5, math.random(1200, 3600)) -- 20 to 60 minutes
end

return entity
