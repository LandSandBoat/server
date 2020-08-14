-----------------------------------
-- Area: Pso'Xja
--  Mob: Diremite
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.GYRE_CARLIN_PH, 5, 1800) -- 30 minutes.
end
