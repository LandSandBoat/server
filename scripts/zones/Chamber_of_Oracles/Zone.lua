-----------------------------------
--
-- Zone: Chamber_of_Oracles (168)
--
-----------------------------------
local ID = require("scripts/zones/Chamber_of_Oracles/IDs")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local currentMission = player:getCurrentMission(WINDURST)
    local missionStatus = player:getMissionStatus(player:getNation())
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-177.804, -2.765, -37.893, 179)
    end

    if (prevZone == xi.zone.QUICKSAND_CAVES and currentMission == xi.mission.id.windurst.MOON_READING and missionStatus >= 1) then
        cs = 3
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 3) then
        player:addKeyItem(xi.ki.ANCIENT_VERSE_OF_ALTEPA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ANCIENT_VERSE_OF_ALTEPA)
    end
end

return zone_object
