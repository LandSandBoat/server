-----------------------------------
-- Zone: Residential_Area
-----------------------------------
local ID = require('scripts/zones/Residential_Area/IDs')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    player:eraseStatusEffect(true)
    player:setPos(0, 0, 0, 192)

    return cs
end

zoneObject.onRegionEnter = function(player, region)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
