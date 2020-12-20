-----------------------------------
-- Area: Misareaux Coast
--  NPC: Dilapidated Gate
-- Entrance to Riverne Site #B01
-- !pos -259 -30 276 25
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/Misareaux_Coast/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local copCurrentMission = player:getCurrentMission(COP)
    local copMissions = tpz.mission.id.cop
    local copMissionStatus = player:getCharVar("PromathiaStatus")

    -- Bahamut Battle (requires COP to be completed)
    if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.STORMS_OF_FATE) == QUEST_ACCEPTED and player:getCharVar('StormsOfFate') == 0 then
        player:startEvent(559)
    -- COP 7-2
    elseif copCurrentMission == copMissions.FLAMES_IN_THE_DARKNESS and copMissionStatus == 0 then
        player:startEvent(12)
    -- COP 4-2
    elseif copCurrentMission == copMissions.THE_SAVAGE and copMissionStatus == 0 then
        player:startEvent(8)
    -- COP 2-5
    elseif copCurrentMission == copMissions.ANCIENT_VOWS and copMissionStatus == 0 then
        player:startEvent(6)
    -- Can pass after completing COP 2-4
    elseif copCurrentMission > copMissions.AN_ETERNAL_MELODY or player:hasCompletedMission(COP, copMissions.THE_LAST_VERSE) then
        player:startEvent(552)
    else
        player:messageSpecial(ID.text.DOOR_CLOSED)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 6 or csid == 12 then
        player:setCharVar("PromathiaStatus", 1)
    elseif csid == 559 then
        player:setCharVar('StormsOfFate', 1)
    elseif csid == 8 and option == 1 then
        player:setCharVar("PromathiaStatus", 1)
        player:setPos(729, -20, 410, 88, 29) -- Go to Riverne #B01
    end
end
