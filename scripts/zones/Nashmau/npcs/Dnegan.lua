-----------------------------------
-- Area: Nashmau
--  NPC: Dnegan
-- Involved in quest: Wayward Automaton
-- !pos 29.89 -6 55.83 53
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local theWaywardAutomaton = player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATON)
    local theWaywardAutomatonProgress = player:getCharVar('TheWaywardAutomatonProgress')
    local operationTeatimeProgress = player:getCharVar('OperationTeatimeProgress')

    -- Quest: The WayWard Automaton
    if
        theWaywardAutomaton == xi.questStatus.QUEST_ACCEPTED and
        theWaywardAutomatonProgress == 1
    then
        player:startEvent(289) -- he tells u to go Caedarva Mire
    elseif theWaywardAutomatonProgress == 2 then
        player:startEvent(289) -- Hint to go to Caedarva Mire

    -- Quest: Operation Teatime
    elseif
        operationTeatimeProgress == 2 and
        player:getCharVar('OTT_DayWait') ~= VanadielDayOfTheYear()
    then
        player:startEvent(290) -- CS for Chai
    else
        player:startEvent(288)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 289 then
        player:setCharVar('TheWaywardAutomatonProgress', 2)
    elseif csid == 290 and option == 0 then
        player:setCharVar('OTT_DayWait', VanadielDayOfTheYear())
    elseif csid == 290 and option == 1 then
        player:setCharVar('OperationTeatimeProgress', 3)
        player:setCharVar('OTT_DayWait', 0)
    end
end

return entity
