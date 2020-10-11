-----------------------------------
-- Area: Buburimu Peninsula (118)
--  Mob: Zu
-- Note: PH for Helldiver
-----------------------------------
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.HELLDIVER_PH, 5, math.random(3600, 28800)) -- 1 to 8 hours
end
