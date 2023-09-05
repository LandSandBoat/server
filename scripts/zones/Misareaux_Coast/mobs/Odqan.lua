-----------------------------------
-- Area: Misareaux Coast
--   NM: Odqan
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
local ID = require("scripts/zones/Misareaux_Coast/IDs")
------------------------------
local entity = {}

entity.onMobRoam = function(mob)
    if mob:getWeather() ~= xi.weather.FOG then
        DespawnMob(mob:getID())
    end
end

entity.onMobDisengage = function(mob, weather)
    if mob:getWeather() ~= xi.weather.FOG then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 443)
end

entity.onMobDespawn = function(mob)
    DisallowRespawn(mob:getLocalVar("ph"), false)
    xi.mob.nmTODPersist(mob, math.random(7200, 18000)) -- 2 to 5 hours
end

return entity
