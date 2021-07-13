-----------------------------------
--
-- Zone: Port_San_dOria (232)
--
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/quests/flyers_for_regine")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    quests.ffr.initZone(zone) -- register regions 1 through 5
end

zone_object.onZoneIn = function(player,prevZone)
    local cs = -1

    if xi.settings.ENABLE_ROV == 1 and player:getCurrentMission(ROV) == xi.mission.id.rov.RHAPSODIES_OF_VANADIEL and player:getMainLvl()>=3 then
        cs = 30035
    end

    if
        player:getCurrentMission(ROV) == xi.mission.id.rov.FATES_CALL and
        (player:getRank(player:getNation()) > 5 or
        (player:getCurrentMission(player:getNation()) == xi.mission.id.nation.SHADOW_LORD and player:getMissionStatus(player:getNation()) >= 4))
    then
        cs = 30036
    end

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if xi.settings.NEW_CHARACTER_CUTSCENE == 1 then
            cs = 500
        end
        player:setPos(-104, -8, -128, 227)
        player:setHomePoint()
    elseif (player:getCurrentMission(COP) == xi.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Ulmia_s_Path") == 1) then
        cs = 4
    end

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        if (prevZone == xi.zone.SAN_DORIA_JEUNO_AIRSHIP) then
            cs = 702
            player:setPos(-1.000, 0.000, 44.000, 0)
        else
            player:setPos(80, -16, -135, 165)
        end
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
    quests.ffr.onRegionEnter(player, region) -- player approaching Flyers for Regine NPCs
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onTransportEvent = function(player, transport)
    player:startEvent(700)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 500) then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    elseif (csid == 700) then
        player:setPos(0, 0, 0, 0, 223)
    elseif (csid == 4) then
        player:setCharVar("COP_Ulmia_s_Path",2)
    elseif csid == 30035 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.RHAPSODIES_OF_VANADIEL)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RESONACE)
    elseif csid == 30036 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.FATES_CALL)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.WHAT_LIES_BEYOND)
    end
end

return zone_object
