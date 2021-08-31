-----------------------------------
--
-- Zone: Silver_Sea_route_to_Nashmau
--
-----------------------------------
local ID = require("scripts/zones/Silver_Sea_route_to_Nashmau/IDs")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    return cs
end

zone_object.onTransportEvent = function(player, transport)
    player:startEvent(1025)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 1025) then
        player:setPos(0, 0, 0, 0, 53)
    end
end

return zone_object
