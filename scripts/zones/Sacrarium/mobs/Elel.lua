-----------------------------------
-- Area: Sacrarium
--   NM: Elel
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobRoam = function(mob)
    local hour    = VanadielHour()
    local weather = mob:getWeather()
    if
        (hour >= 4 and hour < 20) or                                     -- Not night.
        (weather ~= xi.weather.GLOOM and weather ~= xi.weather.DARKNESS) -- Not dark weather.
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
