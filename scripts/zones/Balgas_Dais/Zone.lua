-----------------------------------
--
-- Zone: Balgas_Dais (146)
--
-----------------------------------
local ID = require("scripts/zones/Balgas_Dais/IDs")
require("scripts/globals/settings")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(317.842, -126.158, 380.143, 127)
    end
    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
    -- print("Player: ", player)
    -- print("RESULT: ", regionID)
end

zone_object.onEventUpdate = function(player, csid, option)
    -- print("zone CSID: ", csid)
    -- print("zone RESULT: ", option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
