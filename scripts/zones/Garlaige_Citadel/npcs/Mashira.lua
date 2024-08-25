-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Mashira
-- Involved in Quests: Rubbish day, Making Amens!
-- !pos 141 -6 138 200
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.RUBBISH_DAY) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('RubbishDayVar') == 0
    then
        player:startEvent(11, 1) -- For the quest "Rubbish day"
    else
        player:startEvent(11, 3) -- Standard dialog and menu
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    local rubbishDay = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.RUBBISH_DAY)
    if
        csid == 11 and
        option == 1 and
        rubbishDay == xi.questStatus.QUEST_ACCEPTED
    then
        player:delKeyItem(xi.ki.MAGIC_TRASH)
        player:setCharVar('RubbishDayVar', 1)
    end
end

return entity
