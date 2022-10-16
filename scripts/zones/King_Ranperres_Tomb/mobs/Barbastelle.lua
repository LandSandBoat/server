-----------------------------------
-- Area: King Ranperre's Tomb
--   NM: Barbastelle
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 175)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(1800, 5400)) -- 30 to 90 minutes
end

return entity
