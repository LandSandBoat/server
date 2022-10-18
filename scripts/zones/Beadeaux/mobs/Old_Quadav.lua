-----------------------------------
-- Area: Beadeaux
--  Mob: Old Quadav
-- PH for Ge'Dha Evileye
-----------------------------------
local ID = require("scripts/zones/Beadeaux/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GE_DHA_EVILEYE_PH, 10, 3600) -- 1 hour minimum
end

return entity
