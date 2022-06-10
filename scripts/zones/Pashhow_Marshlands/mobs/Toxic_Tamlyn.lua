-----------------------------------
-- Area: Pashhow Marshlands
--   NM: Toxic Tamlyn
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 20)
end

entity.onMobRoam = function(mob)
    if not (mob:getWeather() == xi.weather.RAIN or mob:getWeather() == xi.weather.SQUALL) then
        DespawnMob(mob:getID())
    end
end

entity.onMobDisengage = function(mob)
    if not (mob:getWeather() == xi.weather.RAIN or mob:getWeather() == xi.weather.SQUALL) then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 213)
end

entity.onMobDespawn = function(mob)
    DisallowRespawn(mob:getID(), true)
    SetServerVariable("TamlynRespawn",(os.time() + 3600))
end

return entity
