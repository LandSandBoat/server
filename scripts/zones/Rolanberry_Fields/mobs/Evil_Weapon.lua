-----------------------------------
-- Area: Rolanberry Fields
--  Mob: Evil Weapon
-- Note: PH for Eldritch Edge
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.ELDRITCH_EDGE_PH, 20, math.random(5400, 7200)) -- 90 to 120 minutes
end

return entity
