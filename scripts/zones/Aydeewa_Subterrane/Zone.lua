-----------------------------------
-- Zone: Aydeewa_Subterrane (68)
-----------------------------------
local ID = require('scripts/zones/Aydeewa_Subterrane/IDs')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerRegion(1, 378, -3, 338, 382, 3, 342)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(356.503, -0.364, -179.607, 122)
    end

    return cs
end

zoneObject.onRegionEnter = function(player, region)
end

zoneObject.onRegionLeave = function(player, region)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
