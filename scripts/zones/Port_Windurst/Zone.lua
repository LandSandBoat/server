-----------------------------------
--
-- Zone: Port_Windurst (240)
--
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    SetExplorerMoogles(ID.npc.EXPLORER_MOOGLE)
end

zone_object.onZoneIn = function(player,prevZone)
    local cs = -1

    if ENABLE_ROV == 1 and player:getCurrentMission(ROV) == xi.mission.id.rov.RHAPSODIES_OF_VANADIEL and player:getMainLvl()>=3 then
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
        if NEW_CHARACTER_CUTSCENE == 1 then
            cs = 305
        end
        player:setPos(-120, -5.5, 175, 48)
        player:setHomePoint()
    end
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        if (prevZone == xi.zone.WINDURST_JEUNO_AIRSHIP) then
            cs = 10004
            player:setPos(228.000, -3.000, 76.000, 160)
        else
            local position = math.random(1, 5) + 195
            player:setPos(position, -15.56, 258, 65)
        end
    end
    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onTransportEvent = function(player, transport)
    player:startEvent(10002)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 305) then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    elseif (csid == 10002) then
        player:setPos(0, 0, 0, 0, 225)
    elseif csid == 30035 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.RHAPSODIES_OF_VANADIEL)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RESONACE)
    elseif csid == 30036 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.FATES_CALL)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.WHAT_LIES_BEYOND)
    end
end

return zone_object
