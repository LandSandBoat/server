-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Mashira
-- Involved in Quests: Rubbish day, Making Amens!
-- !pos 141 -6 138 200
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RUBBISH_DAY) == QUEST_ACCEPTED and
        player:getCharVar('RubbishDayVar') == 0
    then
        player:startEvent(11, 1) -- For the quest "Rubbish day"
    elseif player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_AMENS) == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.BROKEN_WAND) then
            player:startEvent(11, 3)
        else player:startEvent(11, 0) -- Making Amens dialogue
        end
    else
        player:startEvent(11, 3) -- Standard dialog and menu
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    local rubbishDay = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RUBBISH_DAY)
    local makingAmens = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_AMENS)
    if csid == 11 and option == 1 and rubbishDay == QUEST_ACCEPTED then
        player:delKeyItem(xi.ki.MAGIC_TRASH)
        player:setCharVar('RubbishDayVar', 1)
    elseif csid == 11 and option == 0 and makingAmens == QUEST_ACCEPTED then
        player:addKeyItem(xi.ki.BROKEN_WAND) --Broken Wand
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BROKEN_WAND)
        player:tradeComplete()
    end
end

return entity
