-----------------------------------
-- Area: Upper Jeuno
--  NPC: Rhea Myuliah
-- Type: Standard NPC
-- !pos -56.220 -1 101.805 244
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local lakesideMin = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LAKESIDE_MINUET)
    local lakeProg = player:getCharVar("Lakeside_Minuet_Progress")
    if (lakeProg >= 3) then
        player:startEvent(10116)
    elseif (lakeProg == 2) then
        player:startEvent(10115) -- You danced! Here's your hint
        player:setCharVar("Lakeside_Minuet_Progress", 3)
    elseif (lakeProg == 1) then
        player:startEvent(10114) -- After the CS
    elseif (lakesideMin == QUEST_ACCEPTED and lakeProg < 1) then
        player:startEvent(10113) -- intial CS
        player:setCharVar("Lakeside_Minuet_Progress", 1)
    elseif (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_ACCEPTED and player:getCharVar("QuestStatus_DNC_AF1")==1) then
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
