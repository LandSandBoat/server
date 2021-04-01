-----------------------------------
--
-- Zone: Nashmau (53)
--
-----------------------------------
local ID = require("scripts/zones/Nashmau/IDs")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        if (prevZone == xi.zone.ARRAPAGO_REEF and player:getCurrentMission(TOAU) == xi.mission.id.toau.THE_BLACK_COFFIN and player:getCharVar("AhtUrganStatus") == 3) then
            cs = 281
            player:setPos(-13, 2, -62, 194)
        elseif (prevZone == xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU) then
            cs = 201
            player:setPos(11, 2, -102, 128)
        else
            player:setPos(40.658, -7.527, -24.001, 128)
        end
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onTransportEvent = function(player, transport)
    if (transport == 59) then
        player:startEvent(200)
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 200) then
        player:setPos(0, -2, 0, 0, 59)
    elseif (csid == 281) then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.THE_BLACK_COFFIN)
        player:setCharVar("AhtUrganStatus", 0)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.GHOSTS_OF_THE_PAST)
    end
end

return zone_object
