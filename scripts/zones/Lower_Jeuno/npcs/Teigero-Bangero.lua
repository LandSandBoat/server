-----------------------------------
-- Area: Lower Jeuno
--  NPC: Teigero-Bangero
-- Involved in Quests: The Lost Cardian
-- !pos -58 0 -143 245
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local theKindCardian = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_KIND_CARDIAN)

    if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_WONDER_MAGIC_SET) == QUEST_AVAILABLE then
        player:startEvent(34) -- Base Standard CS & dialog
    elseif player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.COOK_S_PRIDE) ~= QUEST_COMPLETED then
        local rand = math.random(1, 2)
        if rand == 1 then
            player:startEvent(75) -- During Panta and Naruru Quests
        else
            player:startEvent(32) -- Same
        end
    elseif player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_LOST_CARDIAN) == QUEST_AVAILABLE then
        if player:getCharVar('theLostCardianVar') == 0 then
            player:startEvent(29) -- First dialog for "The lost cardian" quest
        else
            player:startEvent(66)
        end
    elseif theKindCardian == QUEST_ACCEPTED then
        player:startEvent(66) -- During quest "The kind cardien"
    elseif theKindCardian == QUEST_COMPLETED then
        player:startEvent(67) -- New standard dialog after "The kind cardian"
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 29 then
        player:setCharVar('theLostCardianVar', 1)
    end
end

return entity
