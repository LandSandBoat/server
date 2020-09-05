-----------------------------------
-- Area: Carpenters' Landing
--  Mob: Birdtrap
-- Note: Placeholder Orctrap
-----------------------------------
local ID = require("scripts/zones/Carpenters_Landing/IDs")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.ORCTRAP_PH, 5, math.random(3600, 25200)) -- 1 to 7 hours
end
