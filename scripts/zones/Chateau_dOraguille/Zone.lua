-----------------------------------
--
-- Zone: Chateau_dOraguille (233)
--
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, -95, 0, 75, -85, 5, 85)
end

zone_object.onZoneIn = function(player, prevZone)

    local currentMission = player:getCurrentMission(SANDORIA)
    local missionStatus = player:getMissionStatus(player:getNation())
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(14.872, 8.918, 24.002, 255)
    end

    if
        prevZone == xi.zone.NORTHERN_SAN_DORIA and currentMission == xi.mission.id.sandoria.THE_CRYSTAL_SPRING and
        player:getMissionStatus(player:getNation()) == 2
    then
        cs = 555
    elseif currentMission == xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and missionStatus == 1 then
        cs = 10
    elseif prevZone == xi.zone.NORTHERN_SAN_DORIA and player:hasKeyItem(xi.ki.MESSAGE_TO_JEUNO_SANDORIA) then
        cs = 509
    elseif currentMission == xi.mission.id.sandoria.COMING_OF_AGE and missionStatus == 0 then
        cs = 116
    end

    return cs

end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
    local regionID = region:GetRegionID()

    if regionID == 1 then
        if player:getCharVar("SecretWeaponStatus") == 1 then
            player:startEvent(0)
        end
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)

    if csid == 555 then
        player:setMissionStatus(player:getNation(), 3)
    elseif csid == 509 then
        player:setMissionStatus(player:getNation(), 9)
        player:delKeyItem(xi.ki.MESSAGE_TO_JEUNO_SANDORIA)
    elseif csid == 0 then
        player:setCharVar("SecretWeaponStatus", 2)
    elseif csid == 10 then
        player:setMissionStatus(player:getNation(), 2)
    elseif csid == 116 then
        player:setMissionStatus(player:getNation(), 1)
    end

end

return zone_object
