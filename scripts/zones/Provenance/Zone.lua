-----------------------------------
--
-- Zone: Provenance (222)
--
-----------------------------------
local ID = require("scripts/zones/Provenance/IDs")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function( player, prevZone)
    cs = -1
    if ( player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-640, -20, -519.999, 192)
    end
    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
