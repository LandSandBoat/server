-----------------------------------
-- Area: Metalworks
--  NPC: Pius
-- Involved In Mission: Journey Abroad
-- !pos 99 -21 -12 237
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local Mission = player:getCurrentMission(player:getNation())
    local missionStatus = player:getMissionStatus(player:getNation())

    if
        Mission == xi.mission.id.sandoria.JOURNEY_TO_BASTOK and missionStatus == 3 or
        Mission == xi.mission.id.sandoria.JOURNEY_TO_BASTOK2 and missionStatus == 8
    then
        player:startEvent(355)
    elseif
        Mission == xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK and missionStatus == 3 or
        Mission == xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2 and missionStatus == 8
    then
        player:startEvent(355, 1)
    elseif
        Mission == xi.mission.id.sandoria.JOURNEY_TO_BASTOK or
        Mission == xi.mission.id.sandoria.JOURNEY_TO_BASTOK2 or
        Mission == xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2 and missionStatus < 11
    then
        player:startEvent(356)
    else
        player:startEvent(350)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 355) then
        if (player:getMissionStatus(player:getNation()) == 3) then
            player:setMissionStatus(player:getNation(), 4)
        else
            player:setMissionStatus(player:getNation(), 9)
        end
    end
end

return entity
