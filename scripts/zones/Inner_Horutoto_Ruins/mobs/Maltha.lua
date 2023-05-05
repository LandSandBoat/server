-----------------------------------
-- Area: Inner Horutoto Ruins
--   NM: Maltha
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 288)
    xi.roe.onRecordTrigger(player, 273)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1 to 2 hours
end

return entity
