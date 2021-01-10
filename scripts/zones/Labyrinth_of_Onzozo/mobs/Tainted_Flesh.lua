-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Tainted Flesh
-- Note: Place holder for Hellion
-----------------------------------
local ID = require("scripts/zones/Labyrinth_of_Onzozo/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.HELLION_PH, 5, math.random(7200, 14400)) -- 2 to 4 hours
end

return entity
