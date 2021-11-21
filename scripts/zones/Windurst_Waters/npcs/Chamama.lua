-----------------------------------
-- Area: Windurst Waters
--  NPC: Chamama
-- Involved In Quest: Inspector's Gadget
-- Starts Quest: In a Pickle
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/settings/main")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local InAPickle = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.IN_A_PICKLE)
    local count = trade:getItemCount()
    local gil = trade:getGil()

    if (InAPickle == QUEST_ACCEPTED or InAPickle == QUEST_COMPLETED) and trade:hasItemQty(583, 1) == true and count == 1 and gil == 0 then
        local rand = math.random(1, 4)
        if rand <= 2 then
            if InAPickle == QUEST_ACCEPTED then
                player:startEvent(659) -- IN A PICKLE: Quest Turn In (1st Time)
            elseif InAPickle == QUEST_COMPLETED then
                player:startEvent(662, 200)
            end
        elseif rand == 3 then
            player:startEvent(657) -- IN A PICKLE: Too Light
            player:tradeComplete(trade)
        elseif rand == 4 then
            player:startEvent(658) -- IN A PICKLE: Too Small
            player:tradeComplete(trade)
        end
    end
end

entity.onTrigger = function(player, npc)
    local InAPickle = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.IN_A_PICKLE)
    local NeedToZone = player:needToZone()

    if InAPickle == QUEST_AVAILABLE and NeedToZone == false then
        local rand = math.random(1, 2)
        if rand == 1 then
            player:startEvent(654, 0, 4444) -- IN A PICKLE + RARAB TAIL: Quest Begin
        else
            player:startEvent(651) -- Standard Conversation
        end
    elseif InAPickle == QUEST_ACCEPTED or player:getCharVar("QuestInAPickle_var") == 1 then
        player:startEvent(655, 0, 4444) -- IN A PICKLE + RARAB TAIL: Quest Objective Reminder
    elseif InAPickle == QUEST_COMPLETED and NeedToZone then
        player:startEvent(660) -- IN A PICKLE: After Quest
    elseif InAPickle == QUEST_COMPLETED and NeedToZone == false and player:getCharVar("QuestInAPickle_var") ~= 1 then
        local rand = math.random(1, 2)
        if rand == 1 then
            player:startEvent(661) -- IN A PICKLE: Repeatable Quest Begin
        else
            player:startEvent(651) -- Standard Conversation
        end
    else
        player:startEvent(651) -- Standard Conversation
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 654 and option == 1 then -- IN A PICKLE + RARAB TAIL: Quest Begin
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.IN_A_PICKLE)
    elseif csid == 659 then -- IN A PICKLE: Quest Turn In (1st Time)
        player:tradeComplete()
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.IN_A_PICKLE)
        player:needToZone(true)
        player:addItem(12505)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 12505)
        player:addGil(xi.settings.GIL_RATE*200)
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.GIL_RATE*200)
        player:addFame(WINDURST, 75)
    elseif csid == 661 and option == 1 then
        player:setCharVar("QuestInAPickle_var", 1)
    elseif csid == 662 then -- IN A PICKLE + 200 GIL: Repeatable Quest Turn In
        player:tradeComplete()
        player:needToZone(true)
        player:addGil(xi.settings.GIL_RATE*200)
        player:addFame(WINDURST, 8)
        player:setCharVar("QuestInAPickle_var", 0)
    end
end

return entity
