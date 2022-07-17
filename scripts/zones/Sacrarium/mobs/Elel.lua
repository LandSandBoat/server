-----------------------------------
-- Area: Sacrarium
--   NM: Balor
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobDisengage = function(mob)
    if not (mob:getWeather() == xi.weather.GLOOM or mob:getWeather() == xi.weather.DARKNESS) or (VanadielHour() >= 4 and VanadielHour() < 20) then
        DespawnMob(mob:getID())
    end
end

entity.onMobRoam = function(mob)
    if not (mob:getWeather() == xi.weather.GLOOM or mob:getWeather() == xi.weather.DARKNESS) or (VanadielHour() >= 4 and VanadielHour() < 20) then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(7200)
    mob:setLocalVar("cooldown", os.time() + 7200)
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no dark weather and immediate despawn
end

return entity
