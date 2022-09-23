-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Ghoul
-- Note: Place holder for Ah Puch
-----------------------------------
local ID = require("scripts/zones/Outer_Horutoto_Ruins/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.AH_PUCH_PH, 20, math.random(3600, 10800)) -- 1 to 3 hours
end

return entity
