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

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(567.624, -20, 280.775, 120)
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

    if os.time() > GetServerVariable(string.format("[SPAWN]%s", odqan)) and weather == xi.weather.FOG then
        DisallowRespawn(odqan, false)
        -- While it is very likely that Odqan will spawn at the beginning of foggy weather, it is not guaranteed.
        GetMobByID(odqan):setRespawnTime(math.random(5, 30))
    else
        DisallowRespawn(odqan, true)
    end
end

return zoneObject
