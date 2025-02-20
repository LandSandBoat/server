-----------------------------------
-- Area: Windurst Waters
--  NPC: Chamama
-- Involved In Quest: Inspector's Gadget
-- Starts Quest: In a Pickle
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local inAPickle = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.IN_A_PICKLE)

    if
        (inAPickle == xi.questStatus.QUEST_ACCEPTED or inAPickle == xi.questStatus.QUEST_COMPLETED) and
        trade:hasItemQty(xi.item.SMOOTH_STONE, 1) and
        trade:getItemCount() == 1 and
        trade:getGil() == 0
    then
        local rand = math.random(1, 4)
        if rand <= 2 then
            if inAPickle == xi.questStatus.QUEST_ACCEPTED then
                player:startEvent(659) -- IN A PICKLE: Quest Turn In (1st Time)
            elseif inAPickle == xi.questStatus.QUEST_COMPLETED then
                player:startEvent(662, 200)
            end
        elseif rand == 3 then
            player:startEvent(657) -- IN A PICKLE: Too Light
            player:tradeComplete()
        elseif rand == 4 then
            player:startEvent(658) -- IN A PICKLE: Too Small
            player:tradeComplete()
        end
    end
end

entity.onTrigger = function(player, npc)
    local inAPickle = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.IN_A_PICKLE)
    local needToZone = player:needToZone()

    if inAPickle == xi.questStatus.QUEST_AVAILABLE and not needToZone then
        local rand = math.random(1, 2)
        if rand == 1 then
            player:startEvent(654, 0, xi.item.RARAB_TAIL) -- IN A PICKLE + RARAB TAIL: Quest Begin
        else
            player:startEvent(651) -- Standard Conversation
        end
    elseif
        inAPickle == xi.questStatus.QUEST_ACCEPTED or
        player:getCharVar('QuestInAPickle_var') == 1
    then
        player:startEvent(655, 0, xi.item.RARAB_TAIL) -- IN A PICKLE + RARAB TAIL: Quest Objective Reminder
    elseif inAPickle == xi.questStatus.QUEST_COMPLETED and needToZone then
        player:startEvent(660) -- IN A PICKLE: After Quest
    elseif
        inAPickle == xi.questStatus.QUEST_COMPLETED and
        not needToZone and
        player:getCharVar('QuestInAPickle_var') ~= 1
    then
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

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 654 and option == 1 then -- IN A PICKLE + RARAB TAIL: Quest Begin
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.IN_A_PICKLE)
    elseif csid == 659 then -- IN A PICKLE: Quest Turn In (1st Time)
        player:tradeComplete()
        player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.IN_A_PICKLE)
        player:needToZone(true)
        player:addItem(xi.item.BONE_HAIRPIN)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.BONE_HAIRPIN)
        npcUtil.giveCurrency(player, 'gil', 200)
        player:addFame(xi.fameArea.WINDURST, 75)
    elseif csid == 661 and option == 1 then
        player:setCharVar('QuestInAPickle_var', 1)
    elseif csid == 662 then -- IN A PICKLE + 200 GIL: Repeatable Quest Turn In
        player:tradeComplete()
        player:needToZone(true)
        player:addGil(xi.settings.main.GIL_RATE * 200)
        player:addFame(xi.fameArea.WINDURST, 8)
        player:setCharVar('QuestInAPickle_var', 0)
    end
end

return entity
