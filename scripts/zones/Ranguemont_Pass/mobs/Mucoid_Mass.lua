-----------------------------------
-- Area: Ranguemont Pass
--   NM: Mucoid Mass
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 345)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(5400, 6000)) -- 90 to 100 minutes
end

return entity
