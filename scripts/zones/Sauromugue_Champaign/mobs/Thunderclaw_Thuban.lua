-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Thunderclaw Thuban
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 274)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(5400, 7200)) -- 90 to 120 minutes
end

return entity
