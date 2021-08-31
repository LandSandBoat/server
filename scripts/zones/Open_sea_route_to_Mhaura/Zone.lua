-----------------------------------
--
-- Zone: Open_sea_route_to_Mhaura (47)
--
-----------------------------------
local ID = require("scripts/zones/Open_sea_route_to_Mhaura/IDs")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        local position = math.random(-2, 2) + 0.150
        player:setPos(position, -2.100, 3.250, 64)
    end
    return cs
end

zone_object.onTransportEvent = function(player, transport)
    player:startEvent(1028)
    player:messageSpecial(ID.text.DOCKING_IN_MHAURA)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 1028) then
        player:setPos(0, 0, 0, 0, 249)
    end
end

return zone_object
