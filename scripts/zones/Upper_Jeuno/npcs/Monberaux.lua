-----------------------------------
-- Area: Upper Jeuno
--  NPC: Monberaux
-- Starts and Finishes Quest: The Lost Cardian (finish), The kind cardian (start)
-- Involved in Quests: Save the Clock Tower
-- Involved in handling his how his alter ego reacts in combat.
-- !pos -43 0 -1 244
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local minimumGil = 10000
    local elixirTotal = 2

    local finalElixir = player:getCharVar('finalElixir')
    local monbAoe = player:getCharVar('monbAoe')
    local gilAmount = trade:getGil()

    -- Check trade for elixir/hi-elixir
    -- TODO: add logic to trade more than 1 at a time, or more than 1 type at a time.
    if
        trade:hasItemQty(xi.item.ELIXIR, 1) or
        trade:hasItemQty(xi.item.HI_ELIXIR, 1)
    then
        if finalElixir < elixirTotal then
            player:setCharVar('finalElixir', finalElixir + 1)
            player:printToPlayer(string.format('Thank you for that medicine. You currently have %d vials remaining.', finalElixir + 1), 0, 'Monberaux')
            player:tradeComplete()
        elseif finalElixir == elixirTotal then
            player:printToPlayer('I am already holding too many vials for you. Come back after I`ve treated you.', 0, 'Monberaux')
        else
            player:printToPlayer('What do I need this for?', 0, 'Monberaux')
        end

        return
    end

    -- Check for ailment potion AoE and for gil value
    -- TODO: Possibly make required more based on how much gil the player has.
    if monbAoe ~= 1 then
        if gilAmount >= minimumGil then
            player:setCharVar('monbAoe', 1, NextJstWeek())
            player:printToPlayer('Thank you for that donation! My potions will now affect all patrons until the end of the week.', 0, 'Monberaux')
            player:tradeComplete()
        else
            player:printToPlayer('My services are worth at minimum 10,000 gil.', 0, 'Monberaux')
        end

        return
    else
        player:printToPlayer('As much as I appreciate the coin, you`ve already donated this week.', 0, 'Monberaux')
        return
    end
end

entity.onTrigger = function(player, npc)
    local theLostCardien = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_LOST_CARDIAN)
    local cooksPride = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.COOKS_PRIDE)

    if
        cooksPride == xi.questStatus.QUEST_COMPLETED and
        theLostCardien == xi.questStatus.QUEST_AVAILABLE and
        player:getCharVar('theLostCardianVar') == 2
    then
        player:startEvent(33) -- Long CS & Finish Quest "The Lost Cardian"

    elseif
        cooksPride == xi.questStatus.QUEST_COMPLETED and
        theLostCardien == xi.questStatus.QUEST_AVAILABLE and
        player:getCharVar('theLostCardianVar') == 3
    then
        player:startEvent(34) -- Shot CS & Finish Quest "The Lost Cardian"

    elseif
        theLostCardien == xi.questStatus.QUEST_COMPLETED and
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_KIND_CARDIAN) == xi.questStatus.QUEST_ACCEPTED
    then
        player:startEvent(32)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        (csid == 33 and option == 0) or
        (csid == 34 and option == 0)
    then
        player:addTitle(xi.title.TWOS_COMPANY)
        player:setCharVar('theLostCardianVar', 0)
        npcUtil.giveCurrency(player, 'gil', 2100)
        npcUtil.giveKeyItem(player, xi.ki.TWO_OF_SWORDS)
        player:addFame(xi.fameArea.JEUNO, 30)
        player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_LOST_CARDIAN)
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_KIND_CARDIAN) -- Start next quest "THE_KING_CARDIAN"
    elseif csid == 33 and option == 1 then
        player:setCharVar('theLostCardianVar', 3)
    end
end

return entity
