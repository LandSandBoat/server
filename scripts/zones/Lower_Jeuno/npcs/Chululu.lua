-----------------------------------
-- Area: Lower Jeuno
--  NPC: Chululu
-- Starts and Finishes Quests: All in the Cards
-- Optional Cutscene at end of Quest: Searching for the Right Words
-- !pos -13 -6 -42 245
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.ALL_IN_THE_CARDS) >= xi.questStatus.QUEST_ACCEPTED then
        if npcUtil.tradeHas(trade, { xi.item.TARUT_CARD_THE_FOOL, xi.item.TARUT_CARD_DEATH, xi.item.TARUT_CARD_THE_KING, xi.item.TARUT_CARD_THE_HERMIT }, true) then
            player:startEvent(10114) -- Finish quest "All in the Cards"
        end
    end
end

entity.onTrigger = function(player, npc)
    local collectTarutCards = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.COLLECT_TARUT_CARDS)
    local rubbishDay        = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.RUBBISH_DAY)
    local allInTheCards     = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.ALL_IN_THE_CARDS)
    local cdate             = player:getCharVar('AllInTheCards_date')

    if
        player:getFameLevel(xi.fameArea.JEUNO) >= 4 and
        collectTarutCards == xi.questStatus.QUEST_COMPLETED and
        allInTheCards == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(10110) -- Start quest 'All in the Cards' with option

    elseif
        allInTheCards >= xi.questStatus.QUEST_ACCEPTED and
        player:getLocalVar('Cardstemp') == 0
    then
        if cdate >= GetSystemTime() then
            player:startEvent(10111) -- During quest 'All in the Cards' and same AllInTheCards_date value
        elseif cdate == 0 then
            player:startEvent(10113) -- Start quest 'All in the Cards' repeat with option
        elseif cdate < GetSystemTime() then
            player:startEvent(10112) -- During quest 'All in the Cards'  THIS ONE GIVES ANOTHER BATCH
        end

    elseif player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.SEARCHING_FOR_THE_RIGHT_WORDS) == xi.questStatus.QUEST_COMPLETED then
        if player:getCharVar('SearchingForRightWords_postcs') < -1 then
            player:startEvent(56)
        else
            player:startEvent(57) -- final state, after all quests complete
        end

    elseif rubbishDay == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(57) -- New standard dialog

    else
        player:startEvent(26) -- Standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        (csid == 10110 or csid == 10112 or csid == 10113) and
        option == 0 and
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.COLLECT_TARUT_CARDS) == xi.questStatus.QUEST_COMPLETED
    then -- ALL_IN_THE_CARDS started, repeated, or additional cards given
        local rand = math.randomInt(1, 4)
        local card = xi.item.TARUT_CARD_THE_FOOL

        if rand == 1 then
            card = xi.item.TARUT_CARD_DEATH
        elseif rand == 2 then
            card = xi.item.TARUT_CARD_THE_HERMIT
        elseif rand == 3 then
            card = xi.item.TARUT_CARD_THE_KING
        end

        if npcUtil.giveItem(player, { { card, 5 } }) then
            player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.ALL_IN_THE_CARDS)
            player:setCharVar('AllInTheCards_date', JstMidnight())
            player:setLocalVar('Cardstemp', 1)
        end

    elseif csid == 10111 then -- same day, have to return later
        player:setLocalVar('Cardstemp', 1)

    elseif csid == 10114 then
        if
            npcUtil.completeQuest(player, xi.questLog.JEUNO, xi.quest.id.jeuno.ALL_IN_THE_CARDS, {
                gil = 600,
                title = xi.title.CARD_COLLECTOR,
                var = { 'AllInTheCards_date' }
            })
        then
            player:addFame(xi.fameArea.SANDORIA, 16)
            player:addFame(xi.fameArea.BASTOK, 16)
            player:addFame(xi.fameArea.WINDURST, 16)
            player:confirmTrade()
        end
    end
end

return entity
