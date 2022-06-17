-----------------------------------
-- Area: Western Altepa Desert
--   NM: Picolaton
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 414)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(5400) -- 90 minutes
end

return entity
