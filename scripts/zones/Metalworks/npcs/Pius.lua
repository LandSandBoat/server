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
    local MissionStatus = player:getCharVar("MissionStatus")

    if
        Mission == tpz.mission.id.sandoria.JOURNEY_TO_BASTOK and MissionStatus == 3 or
        Mission == tpz.mission.id.sandoria.JOURNEY_TO_BASTOK2 and MissionStatus == 8
    then
        player:startEvent(355)
    elseif
        Mission == tpz.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK and MissionStatus == 3 or
        Mission == tpz.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2 and MissionStatus == 8
    then
        player:startEvent(355, 1)
    elseif
        Mission == tpz.mission.id.sandoria.JOURNEY_TO_BASTOK or
        Mission == tpz.mission.id.sandoria.JOURNEY_TO_BASTOK2 or
        Mission == tpz.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2 and MissionStatus < 11
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
        if (player:getCharVar("MissionStatus") == 3) then
            player:setCharVar("MissionStatus", 4)
        else
            player:setCharVar("MissionStatus", 9)
        end
    end
end

return entity
