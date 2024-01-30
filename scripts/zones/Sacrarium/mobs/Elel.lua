-----------------------------------
-- Area: Sacrarium
--   NM: Elel
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDisengage = function(mob)
    if
        not (mob:getWeather() == xi.weather.GLOOM or mob:getWeather() == xi.weather.DARKNESS) or
        (VanadielHour() >= 4 and VanadielHour() < 20)
    then
        DespawnMob(mob:getID())
    end
end

entity.onMobRoam = function(mob)
    if
        not (mob:getWeather() == xi.weather.GLOOM or mob:getWeather() == xi.weather.DARKNESS) or
        (VanadielHour() >= 4 and VanadielHour() < 20)
    then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    mob:setLocalVar('cooldown', os.time() + 7200)
end

-- TODO: implement/verify this "alternates nights with dark weather" claim on ffxiclopedia.
-- Currently assuming it works like Xolotl where it will just spawn the next time it can (dark weather, night time)
entity.onMobDespawn = function(mob)
    --UpdateNMSpawnPoint(mob:getID()) -- TODO: add more spawn points
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no dark weather and immediate despawn
end

return entity
