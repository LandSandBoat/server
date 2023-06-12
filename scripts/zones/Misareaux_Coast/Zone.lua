-----------------------------------
-- Zone: Misareaux_Coast (25)
-----------------------------------
require('scripts/globals/conquest')
require('scripts/globals/helm')
local ID = require('scripts/zones/Misareaux_Coast/IDs')
local misareauxGlobal = require('scripts/zones/Misareaux_Coast/globals')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helm.type.LOGGING)
    misareauxGlobal.ziphiusHandleQM()

    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.ODQAN)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(634, 22, -222, 111)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameHour = function(zone)
    local vHour = VanadielHour()

    if vHour >= 22 or vHour <= 7 then
        misareauxGlobal.ziphiusHandleQM()
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

zoneObject.onZoneWeatherChange = function(weather)
    local odqan = ID.mob.ODQAN

    if
        os.time() > GetServerVariable(string.format("\\[SPAWN\\]%s", odqan)) and
        weather == xi.weather.FOG
    then
        local ph = ID.mob.ODQAN_PH[math.random(1, 2)]
        local pos = GetMobByID(ph):getPos()

        DisallowRespawn(odqan, false)
        DisallowRespawn(ph, true)
        DespawnMob(ph)
        GetMobByID(odqan):setSpawn(pos.x, pos.y, pos.z)
        SpawnMob(odqan)
        -- need to set local var after spawning since spawning resets local vars
        GetMobByID(odqan):setLocalVar("ph", ph)
    else
        DisallowRespawn(odqan, true)
    end
end

return zoneObject
