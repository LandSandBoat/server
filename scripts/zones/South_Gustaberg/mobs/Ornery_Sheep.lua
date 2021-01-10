-----------------------------------
-- Area: South Gustaberg
--  Mob: Ornery Sheep
-- Note: PH for Carnero
-----------------------------------
local ID = require("scripts/zones/South_Gustaberg/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.CARNERO_PH, 5, math.random(300, 3600)) -- 5-60 minutes
end

return entity
