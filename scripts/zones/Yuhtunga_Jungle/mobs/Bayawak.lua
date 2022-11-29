-----------------------------------
-- Area: Yuhtunga Jungle
--   NM: Bayawak
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobRoam = function(mob)
    if not (mob:getWeather() == xi.weather.HOT_SPELL or mob:getWeather() == xi.weather.HEAT_WAVE) then
        DespawnMob(mob:getID())
    end
end

entity.onMobDisengage = function(mob)
    if not (mob:getWeather() == xi.weather.HOT_SPELL or mob:getWeather() == xi.weather.HEAT_WAVE) then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 363)
end

entity.onMobDespawn = function(mob)
    local respawn = math.random(5400, 7200)
    xi.mob.nmTODPersist(mob, respawn)
    SetServerVariable("BAYAWAK_RESPAWN", os.time() + respawn)
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no fire weather and immediate despawn
end

return entity
