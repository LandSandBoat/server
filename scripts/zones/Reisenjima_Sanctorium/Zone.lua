-----------------------------------
-- Zone: Reisenjima Sanctorium (293)
-----------------------------------
local ID = require('scripts/zones/Reisenjima_Sanctorium/IDs')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(0.002, 3.999, -9.876, 190)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
