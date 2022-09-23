-----------------------------------
--
-- Zone: Mordion_Gaol
--
-----------------------------------
local ID = require("scripts/zones/Mordion_Gaol/IDs")
require("scripts/globals/conquest")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getCharVar("inJail") > 0 then
        player:jail()
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
