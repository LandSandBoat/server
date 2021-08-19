-----------------------------------
-- Area: Upper Jeuno
--  NPC: Rhea Myuliah
-- Type: Standard NPC
-- !pos -56.220 -1 101.805 244
-----------------------------------
require("scripts/globals/quests")
require("scripts/settings/main")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_ACCEPTED and player:getCharVar("QuestStatus_DNC_AF1")==1) then
        player:startEvent(10131)
    --Dancer AF: Road to Divadom
    elseif (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_ROAD_TO_DIVADOM) == QUEST_ACCEPTED)  then
        player:startEvent (10138)
    --Dancer AF: Comeback Queen
    elseif (player:getCharVar("comebackQueenCS") == 1) then
        player:startEvent(10145)
    elseif (player:getCharVar("comebackQueenCS") == 3) then
        player:startEvent(10149) -- dance practice
    elseif (player:getCharVar("comebackQueenCS") == 5) then --player cleared Laila's story
        player:startEvent(10155)
    else
        player:startEvent(10121)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid==10131) then
        player:setCharVar("QuestStatus_DNC_AF1", 2)
    end
end

return entity
