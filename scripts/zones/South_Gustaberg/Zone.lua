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

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-601.433, 35.204, -520.031, 1)
    end

    if player:getCurrentMission(COP) == tpz.mission.id.cop.THE_CALL_OF_THE_WYRMKING and player:getCharVar("VowsDone") == 1 then
        cs = 906
    elseif quests.rainbow.onZoneIn(player) then
        cs = 901
    elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") == 1 then
        cs = 37
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
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

function onEventFinish(player, csid, option)
    if csid == 906 then
        if player:getCurrentMission(COP) == tpz.mission.id.cop.A_TRANSIENT_DREAM then
            player:completeMission(COP, tpz.mission.id.cop.A_TRANSIENT_DREAM)
            player:addMission(COP, tpz.mission.id.cop.THE_CALL_OF_THE_WYRMKING)
        end
        player:setCharVar("VowsDone", 0)
    end
end
