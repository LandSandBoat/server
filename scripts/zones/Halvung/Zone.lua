-----------------------------------
--
-- Zone: Halvung (62)
--
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
require("scripts/globals/helm")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    tpz.helm.initZone(zone, tpz.helm.type.MINING)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(160.54, -22.001, 139.988, 244)
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
