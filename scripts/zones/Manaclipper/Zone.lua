-----------------------------------
--
-- Zone: Manaclipper
--
-----------------------------------
local ID = require("scripts/zones/Manaclipper/IDs")
require("scripts/globals/manaclipper")
require("scripts/globals/conquest")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    tpz.manaclipper.onZoneIn(player)

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(0, -3, -8, 60)
    end

    return cs
end

zone_object.onTransportEvent = function(player, transport)
    player:startEvent(100)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 100 then
        player:setPos(0, 0, 0, 0, tpz.zone.BIBIKI_BAY)
    end
end

return zone_object
