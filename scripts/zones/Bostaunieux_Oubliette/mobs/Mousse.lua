-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Mousse
-- Note: PH for Sewer Syrup
-----------------------------------
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SEWER_SYRUP_PH, 10, math.random(7200, 14400)) -- 2 to 4 hours
end

return entity
