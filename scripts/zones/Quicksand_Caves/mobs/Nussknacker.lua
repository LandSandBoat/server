-----------------------------------
-- Area: Quicksand Caves
--   NM: Nussknacker
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobRoam = function(mob)
    if mob:getWeather() ~= xi.weather.SAND_STORM then
        DespawnMob(mob:getID())
    end
end

entity.onMobDisengage = function(mob)
    if mob:getWeather() ~= xi.weather.SAND_STORM then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 435)
    DisallowRespawn(mob:getID(), true)
end

return entity
