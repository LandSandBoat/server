-----------------------------------
-- Area: Misareaux Coast
--   NM: Odqan
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/world")
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

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 443)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    -- Using ID.mob.ODQAN to choose master Odqan for local var reference
    GetMobByID(ID.mob.ODQAN):setLocalVar("chooseOdqan", math.random(1,2)) -- Choose which Odqan will spawn next
    GetMobByID(ID.mob.ODQAN):setLocalVar("odqanRespawn", os.time() + math.random(7200, 18000))  -- 2 to 5 hrs
    DisallowRespawn(mob:getID(), true)
end

return entity
