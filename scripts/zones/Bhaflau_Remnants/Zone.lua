-----------------------------------
--
-- Zone: Bhaflau_Remnants
--
-----------------------------------
local ID = require("scripts/zones/Bhaflau_Remnants/IDs")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    player:addTempItem(5400)

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
