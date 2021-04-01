-----------------------------------
--
-- Zone: The Eldieme Necropolis (195)
--
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.treasure.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    -- rng af2
    if player:getCharVar("fireAndBrimstone") == 2 then
        return 4
    end

    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-438.878, -26.091, 540.004, 126)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 4 then
        player:setCharVar("fireAndBrimstone", 3)
    end
end

return zone_object
