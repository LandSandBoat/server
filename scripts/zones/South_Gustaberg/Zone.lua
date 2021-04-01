-----------------------------------
--
-- Zone: South_Gustaberg (107)
--
-----------------------------------
local ID = require("scripts/zones/South_Gustaberg/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-601.433, 35.204, -520.031, 1)
    end

    if player:getCurrentMission(COP) == xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING and player:getCharVar("VowsDone") == 1 then
        cs = 906
    elseif quests.rainbow.onZoneIn(player) then
        cs = 901
    elseif player:getCurrentMission(WINDURST) == xi.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") == 1 then
        cs = 37
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
    if csid == 901 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 37 then
        if player:getXPos() > -390 then
            if player:getZPos() > -301 then
                player:updateEvent(0, 0, 0, 0, 0, 6)
            else
                player:updateEvent(0, 0, 0, 0, 0, 7)
            end
        end
    end
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 906 then
        if player:getCurrentMission(COP) == xi.mission.id.cop.A_TRANSIENT_DREAM then
            player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.A_TRANSIENT_DREAM)
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING)
        end
        player:setCharVar("VowsDone", 0)
    end
end

return zone_object
