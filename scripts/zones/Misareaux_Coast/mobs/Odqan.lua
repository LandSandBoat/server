-----------------------------------
-- Area: Misareaux Coast
--   NM: Odqan
-----------------------------------
local ID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobRoam = function(mob)
    local weather = mob:getWeather()

    if weather ~= xi.weather.FOG then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 443)
end

entity.onMobDespawn = function(mob)
    local odqan1 = GetMobByID(ID.mob.ODQAN[1])
    local odqan2 = GetMobByID(ID.mob.ODQAN[2])

    if odqan1 and odqan2 then
        local respawnTime = math.random(7200, 18000) -- 2 to 5 hours

        if math.random(1, 2) == 1 then
            odqan1:setLocalVar('canSpawn', 0)
            odqan2:setLocalVar('canSpawn', 1)
            odqan2:setRespawnTime(respawnTime)
        else
            odqan2:setLocalVar('canSpawn', 0)
            odqan1:setLocalVar('canSpawn', 1)
            odqan1:setRespawnTime(respawnTime)
        end
    end
end

return entity
