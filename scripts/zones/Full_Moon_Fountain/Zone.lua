-----------------------------------
--
-- Zone: Full_Moon_Fountain (170)
--
-----------------------------------
local ID = require("scripts/zones/Full_Moon_Fountain/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/settings/main")
require("scripts/globals/titles")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-260.136, 2.09, -325.702, 188)
    end
    if player:getCurrentMission(WINDURST) == xi.mission.id.windurst.FULL_MOON_FOUNTAIN and player:getMissionStatus(player:getNation()) == 3 then
        cs = 50
    elseif player:getCurrentMission(WINDURST) == xi.mission.id.windurst.DOLL_OF_THE_DEAD and player:getMissionStatus(player:getNation()) == 7 then
        cs = 61
    end
    return cs
end

zone_object.afterZoneIn = function(player)
    player:entityVisualPacket("kilk")
    player:entityVisualPacket("izum")
    player:entityVisualPacket("hast")
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)

    if csid == 50 then
        finishMissionTimeline(player, 3, csid, option)
    elseif csid == 61 then
        player:addTitle(xi.title.GUIDING_STAR)
        finishMissionTimeline(player, 3, csid, option)
    end
end

return zone_object
