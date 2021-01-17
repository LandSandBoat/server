-----------------------------------
--
-- Zone: Kazham (250)
--
-----------------------------------
local ID = require("scripts/zones/Kazham/IDs")
require("scripts/globals/conquest")
require("scripts/globals/chocobo")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    tpz.chocobo.initZone(zone)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        if (prevZone == tpz.zone.KAZHAM_JEUNO_AIRSHIP) then
            cs = 10002
        end
        player:setPos(-4.000, -3.000, 14.000, 66)
    end
    return cs
end

zone_object.onTransportEvent = function(player, transport)
    player:startEvent(10000)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 10000) then
        player:setPos(0, 0, 0, 0, 226)
    end
end

return zone_object
