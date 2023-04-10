-----------------------------------
-- Zone: Dynamis-Xarcabard
-----------------------------------
local ID = require('scripts/zones/Dynamis-Xarcabard/IDs')
require('scripts/globals/conquest')
require('scripts/globals/dynamis')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.dynamis.zoneOnInitialize(zone)
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onZoneIn = function(player, prevZone)
    return xi.dynamis.zoneOnZoneIn(player, prevZone)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    xi.dynamis.zoneOnEventFinish(player, csid, option)
end

return zoneObject
