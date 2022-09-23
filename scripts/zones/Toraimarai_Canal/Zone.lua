-----------------------------------
--
-- Zone: Toraimarai Canal (169)
--
-----------------------------------
local ID = require("scripts/zones/Toraimarai_Canal/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.treasure.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-259.98, 21.794, 81.887, 66)
    end
    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
