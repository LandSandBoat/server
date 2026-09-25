-----------------------------------
-- Area: King Ranperre's Tomb
--   NM: Barbastelle
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(1800, 5400))
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 175)
    xi.magian.onMobDeath(mob, player, optParams, set{ 512 })
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(1800, 5400)) -- 30 to 90 minutes
end

return entity
