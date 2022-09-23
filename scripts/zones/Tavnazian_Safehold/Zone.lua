-----------------------------------
-- Zone: Tavnazian_Safehold (26)
-----------------------------------
local ID = require('scripts/zones/Tavnazian_Safehold/IDs')
require('scripts/globals/conquest')
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    -- NOTE: On Retail, Region 1 appears to be a cylindrical region (no Z-axis) that is quite large.  Managed to trigger
    -- it on the top floor while moving up the ramp from homepoint.
    zone:registerRegion(1, -5, -24, 18, 5, -20, 27)
    zone:registerRegion(2, 104, -42, -88, 113, -38, -77)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(27.971, -14.068, 43.735, 66)
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
