-----------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Dyinyinga
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.TARGET_DISTANCE_OFFSET, 50)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 511)
end

return entity
