-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Fallen Major
-- Note: Place holder Hovering Hotpot
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 703, 2, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.HOVERING_HOTPOT_PH, 20, math.random(1800, 3600)) -- 30 to 60 minutes
end
