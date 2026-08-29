-----------------------------------
-- Area: Lower Jeuno
--  NPC: Kurou-Morou
-- Starts and Finishes Quest: Never to Return
-- Involved in Quests: Your Crystal Ball, Searching for the Right Words
-- !pos -4 -6 -28 245
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.NEVER_TO_RETURN) == xi.questStatus.QUEST_ACCEPTED and
        trade:hasItemQty(xi.item.HORN_HAIRPIN, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(203) -- Finish "Never to return" quest
    end
end

entity.onTrigger = function(player, npc)
    local yourCrystalBall = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.YOUR_CRYSTAL_BALL)
    local jeunoFame       = player:getFameLevel(xi.fameArea.JEUNO)

    if
        jeunoFame >= 5 and
        yourCrystalBall == xi.questStatus.QUEST_COMPLETED and
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.NEVER_TO_RETURN) == xi.questStatus.QUEST_AVAILABLE and
        player:getCharVar('QuestNeverToReturn_day') ~= VanadielUniqueDay()
    then
        local prog = player:getCharVar('QuestNeverToReturn_prog')
        if prog <= 2 then
            local fortune = math.randomInt(1, 99)
            player:startEvent(204, fortune) -- Required to get fortune read 3x on 3 diff game days before quest is kicked off
        elseif prog == 3 then
            player:startEvent(202) -- Start 'Never to return' quest
        end

    else
        player:startEvent(193) -- Standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 204 and option == 0 then
        player:incrementCharVar('QuestNeverToReturn_prog', 1)  -- Keep track of how many times the players fortune has been read
        player:setCharVar('QuestNeverToReturn_day', VanadielUniqueDay()) -- new vanadiel day

    elseif csid == 202 and option == 0 then
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.NEVER_TO_RETURN)
        player:setCharVar('QuestNeverToReturn_prog', 0)
        player:setCharVar('QuestNeverToReturn_day', 0)

    elseif csid == 203 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.GARNET_RING)
        else
            npcUtil.giveCurrency(player, 'gil', 1200)
            player:addItem(xi.item.GARNET_RING)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.GARNET_RING)
            player:addFame(xi.fameArea.SANDORIA, 17)
            player:addFame(xi.fameArea.BASTOK, 17)
            player:addFame(xi.fameArea.WINDURST, 17)
            player:tradeComplete()
            player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.NEVER_TO_RETURN)
        end
    end
end

return entity
