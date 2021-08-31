-----------------------------------
--
-- Zone: Abdhaljs_Isle-Purgonorgo
--
-----------------------------------
local ID = require("scripts/zones/Abdhaljs_Isle-Purgonorgo/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    player:addKeyItem(xi.ki.MAP_OF_ABDH_ISLE_PURGONORGO)

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(521.600, -3.000, 563.000, 64)
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
