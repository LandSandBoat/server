-----------------------------------
-- Area: Giddeus (145)
--   NM: Quu Xijo the Illusory
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 283)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(3600, 4200)) -- 60 to 70 minutes
end

return entity
