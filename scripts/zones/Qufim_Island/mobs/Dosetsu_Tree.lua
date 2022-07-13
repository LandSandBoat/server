-----------------------------------
-- Area: Qufim Island
--   NM: Dosetsu Tree
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

-- TODO: Grab spawn positions

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 1)
end

entity.onMobRoam = function(mob)
    if not (mob:getWeather() == xi.weather.THUNDER or mob:getWeather() == xi.weather.THUNDERSTORMS) then
        DespawnMob(mob:getID())
    end
end

entity.onMobDisengage = function(mob)
    if not (mob:getWeather() == xi.weather.THUNDER or mob:getWeather() == xi.weather.THUNDERSTORMS) then
        DespawnMob(mob:getID())
    end
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setLocalVar("respawn", os.time() + 75600)
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no lightning weather and immediate despawn
end

return entity
