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
    local minimumGil = player:getGil() * 0.1
    local elixirTotal = 2

    local finalElixir = player:getCharVar('finalElixir')
    local monbAoe = player:getCharVar('monbAoe')
    local gilAmount = trade:getGil()
    local elixirType = trade:getItemId(0)

    if minimumGil > 100000 then
        minimumGil = 100000
    elseif minimumGil < 10000 then
        minimumGil = 10000
    end

    -- Check trade for elixir/hi-elixir
    -- TODO: add logic to trade more than 1 at a time, or more than 1 type at a time.
    if
        (trade:hasItemQty(xi.item.ELIXIR, 1) or
            trade:hasItemQty(xi.item.HI_ELIXIR, 1)) and
        finalElixir < elixirTotal
    then
        player:startEvent(10243, elixirType, 1, 2, 0, 59615134, 7271819, 4095, 128)
    elseif
        (trade:hasItemQty(xi.item.ELIXIR, 1) or
        trade:hasItemQty(xi.item.HI_ELIXIR, 1)) and
        finalElixir >= elixirTotal
    then
        player:startEvent(10246, elixirType)
    end

    if
        gilAmount >= minimumGil and
        monbAoe == 0
    then
        player:startEvent(10238)
    elseif
        gilAmount >= minimumGil and
        monbAoe == 1
    then
        player:startEvent(10240)
    end
end

entity.onTrigger = function(player, npc)
    local theLostCardien = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_LOST_CARDIAN)
    local cooksPride = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.COOKS_PRIDE)
    local elixirTotal = 2
    local minimumGil = player:getGil() * 0.1

    if minimumGil > 100000 then
        minimumGil = 100000
    elseif minimumGil < 10000 then
        minimumGil = 10000
    end

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

    if
        player:getCharVar('monbAoe') == 0
    then
        player:startEvent(10237, minimumGil, 1, 2964, 3300, 58195966, 3881063, 4480, 128)
    else
        player:startEvent(10239)
    end

    if
        player:getCharVar('finalElixir') <= elixirTotal
    then
        player:startEvent(10241)
    else
        player:startEvent(10244)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local finalElixir = player:getCharVar('finalElixir')
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

    if
        csid == 10238
    then
        player:setCharVar('monbAoe', 1, NextJstWeek())
        player:tradeComplete()
    end

    if
        csid == 10243
    then
        player:setCharVar('finalElixir', finalElixir + 1)
        player:tradeComplete()
    end
end

return entity
