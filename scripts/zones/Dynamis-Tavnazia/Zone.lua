-----------------------------------
--
-- Zone: Dynamis-Tavnazia
--
-----------------------------------
local ID = require("scripts/zones/Dynamis-Tavnazia/IDs")
require("scripts/globals/conquest")
require("scripts/globals/dynamis")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    dynamis.zoneOnInitialize(zone)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    return dynamis.zoneOnZoneIn(player, prevZone)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    dynamis.zoneOnEventFinish(player, csid, option)
end

return zone_object
