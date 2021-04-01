-----------------------------------
--
-- Zone: Hazhalm_Testing_Grounds (78)
--
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/settings")
local ID = require("scripts/zones/Hazhalm_Testing_Grounds/IDs")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(652.174, -272.632, -104.92, 148)
    end

    if (player:getCurrentMission(TOAU) == xi.mission.id.toau.GAZE_OF_THE_SABOTEUR and player:getCharVar("AhtUrganStatus") == 0) then
        cs = 6
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)

    if (csid == 6) then
        player:setCharVar("AhtUrganStatus", 1)
    end
end

return zone_object
