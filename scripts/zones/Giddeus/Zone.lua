-----------------------------------
-- Zone: Giddeus (145)
-----------------------------------
local ID = require('scripts/zones/Giddeus/IDs')
require('scripts/globals/conquest')
require('scripts/globals/treasure')
require('scripts/globals/helm')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.treasure.initZone(zone)
    xi.helm.initZone(zone, xi.helm.type.HARVESTING)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-135.904, -5.788, -300.668, 2)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onRegionEnter = function(player, region)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
