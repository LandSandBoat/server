-----------------------------------
-- Zone: Aydeewa_Subterrane (68)
-----------------------------------
local ID = require('scripts/zones/Aydeewa_Subterrane/IDs')
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, 378, -3, 338, 382, 3, 342)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(356.503, -0.364, -179.607, 122)
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
