-----------------------------------
-- Zone: King Ranperres Tomb (190)
-----------------------------------
local ID = require('scripts/zones/King_Ranperres_Tomb/IDs')
require('scripts/globals/conquest')
require('scripts/globals/treasure')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, -84.302, 6.5, -120.997, -77, 7.5, -114) -- Used for stairs teleport -85.1, 7, -119.9

    UpdateNMSpawnPoint(ID.mob.VRTRA)
    GetMobByID(ID.mob.VRTRA):setRespawnTime(math.random(86400, 259200))

    UpdateNMSpawnPoint(ID.mob.BARBASTELLE)
    GetMobByID(ID.mob.BARBASTELLE):setRespawnTime(math.random(1800, 5400))

    xi.treasure.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(242.012, 5.305, 340.059, 121)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    if triggerArea:GetTriggerAreaID() == 1 then
        player:startCutscene(9)
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

zoneObject.onGameHour = function(zone)
    -- Don't allow Ankou to spawn outside of night
    if VanadielHour() >= 4 and VanadielHour() < 20 then
        DisallowRespawn(ID.mob.ANKOU, true)
    else
        DisallowRespawn(ID.mob.ANKOU, false)
    end
end

return zoneObject
