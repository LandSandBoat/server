-----------------------------------
-- Area: Lufaise Meadows
--   NM: Yal-un Eke
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/world")
require("scripts/globals/mobs")
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.REGAIN, 300)
end

entity.onMobRoam = function(mob)
    if mob:getWeather() ~= xi.weather.FOG then
        DespawnMob(mob:getID())
    end
end

entity.onMobDisengage = function(mob)
    if mob:getWeather() ~= xi.weather.FOG then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 440)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setLocalVar("chooseYalun", math.random(1,2)) -- Choose which PH will be Yal-un Eke next
    mob:setLocalVar("yalunRespawn", os.time() + 3000)  -- 50 minute respawn
    DisallowRespawn(mob:getID(), true)
end

return entity
