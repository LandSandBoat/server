-----------------------------------
-- Area: Uleguerand Range
--  Mob: Polar Hare
-- Note: PH for Skvader
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SKVADER_PH, 10, 3600) -- 1 hour
end

return entity
