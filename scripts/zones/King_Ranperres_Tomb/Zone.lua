-----------------------------------
--
-- Zone: King Ranperres Tomb (190)
--
-----------------------------------
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, -84.302, 6.5, -120.997, -77, 7.5, -114) -- Used for stairs teleport -85.1, 7, -119.9

    UpdateNMSpawnPoint(ID.mob.VRTRA)
    GetMobByID(ID.mob.VRTRA):setRespawnTime(math.random(86400, 259200))

    UpdateNMSpawnPoint(ID.mob.BARBASTELLE)
    GetMobByID(ID.mob.BARBASTELLE):setRespawnTime(math.random(1800, 5400))

    tpz.treasure.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(242.012, 5.305, 340.059, 121)
    end
    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
    if region:GetRegionID() == 1 then
        player:startEvent(9)
    end
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
