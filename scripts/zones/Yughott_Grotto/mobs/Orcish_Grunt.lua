-----------------------------------
-- Area: Yughott Grotto (142)
--  Mob: Orcish Grunt
-- Note: PH for Ashmaker Gotblut
-----------------------------------
local ID = require("scripts/zones/Yughott_Grotto/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.ASHMAKER_GOTBLUT_PH, 5, math.random(7200, 10800)) -- 2 to 3 hours
end

return entity
