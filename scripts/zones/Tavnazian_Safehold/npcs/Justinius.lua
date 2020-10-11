-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Justinius
-- Involved in mission : COP2-3
-- !pos 76 -34 68 26
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local currentMission = player:getCurrentMission(COP)
    local missionStatus = player:getCharVar("PromathiaStatus")
    local missions = tpz.mission.id.cop

    if currentMission == missions.DISTANT_BELIEFS and missionStatus == 3 then
        player:startEvent(113)
    elseif currentMission == missions.AN_ETERNAL_MELODY and missionStatus == 1 then
        player:startEvent(127)
    elseif currentMission == missions.SHELTERING_DOUBT and missionStatus == 2 then
        player:startEvent(109)
    elseif currentMission == missions.THE_SAVAGE and missionStatus == 2 then
        player:startEvent(110)
    else
        player:startEvent(123)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if csid == 113 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, tpz.mission.id.cop.DISTANT_BELIEFS)
        player:addMission(COP, tpz.mission.id.cop.AN_ETERNAL_MELODY)
    elseif csid == 109 then
        player:setCharVar("PromathiaStatus", 3)
    elseif csid == 110 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, tpz.mission.id.cop.THE_SAVAGE)
        player:addMission(COP, tpz.mission.id.cop.THE_SECRETS_OF_WORSHIP)
        player:addTitle(tpz.title.NAGMOLADAS_UNDERLING)
    end

end
