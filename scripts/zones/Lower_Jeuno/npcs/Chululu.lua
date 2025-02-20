-----------------------------------
-- Area: Lower Jeuno
--  NPC: Chululu
-- Starts and Finishes Quests: Collect Tarut Cards, Rubbish Day, All in the Cards
-- Optional Cutscene at end of Quest: Searching for the Right Words
-- !pos -13 -6 -42 245
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.COLLECT_TARUT_CARDS) == xi.questStatus.QUEST_ACCEPTED then
        if npcUtil.tradeHas(trade, { xi.item.TARUT_CARD_THE_FOOL, xi.item.TARUT_CARD_DEATH, xi.item.TARUT_CARD_THE_KING, xi.item.TARUT_CARD_THE_HERMIT }, true) then
            player:startEvent(200) -- Finish quest "Collect Tarut Cards"
        end
    elseif player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.ALL_IN_THE_CARDS) >= xi.questStatus.QUEST_ACCEPTED then
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
        player:getFameLevel(xi.fameArea.JEUNO) >= 3 and
        collectTarutCards == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(28) -- Start quest 'Collect Tarut Cards' with option

    elseif collectTarutCards == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(27) -- During quest 'Collect Tarut Cards'

    elseif
        collectTarutCards == xi.questStatus.QUEST_COMPLETED and
        rubbishDay == xi.questStatus.QUEST_AVAILABLE and
        player:getCharVar('RubbishDay_day') ~= VanadielDayOfTheYear()
    then
        -- prog = player:getCharVar('RubbishDay_prog')
        -- if prog <= 2 then
        --     player:startEvent(199) -- Required to get compatibility 3x on 3 diff game days before quest is kicked off
        -- elseif prog == 3 then
        player:startEvent(198) -- Start quest "Rubbish Day" with option
        -- end

    elseif
        collectTarutCards == xi.questStatus.QUEST_COMPLETED and
        rubbishDay == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(57) -- Standard dialog between 2 quests

    elseif
        rubbishDay == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('RubbishDayVar') == 0
    then
        player:startEvent(49) -- During quest 'Rubbish Day'

    elseif
        rubbishDay == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('RubbishDayVar') == 1
    then
        player:startEvent(197) -- Finish quest 'Rubbish Day'

    elseif
        player:getFameLevel(xi.fameArea.JEUNO) >= 4 and
        collectTarutCards == xi.questStatus.QUEST_COMPLETED and
        allInTheCards == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(10110) -- Start quest 'All in the Cards' with option

    elseif
        allInTheCards >= xi.questStatus.QUEST_ACCEPTED and
        player:getLocalVar('Cardstemp') == 0
    then
        if cdate >= os.time() then
            player:startEvent(10111) -- During quest 'All in the Cards' and same AllInTheCards_date value
        elseif cdate == 0 then
            player:startEvent(10113) -- Start quest 'All in the Cards' repeat with option
        elseif cdate < os.time() then
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
    if csid == 28 and option == 0 then
        local rand = math.random(1, 4)
        local card = xi.item.TARUT_CARD_THE_FOOL

        if rand == 1 then
            card = xi.item.TARUT_CARD_DEATH
        elseif rand == 2 then
            card = xi.item.TARUT_CARD_THE_HERMIT
        elseif rand == 3 then
            card = xi.item.TARUT_CARD_THE_KING
        end

        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, card)
        else
            player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.COLLECT_TARUT_CARDS)
            player:addItem(card, 5)
            player:messageSpecial(ID.text.ITEM_OBTAINED, card)
        end

    elseif csid == 200 then
        player:addTitle(xi.title.CARD_COLLECTOR)
        player:addFame(xi.fameArea.JEUNO, 30)
        player:tradeComplete()
        player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.COLLECT_TARUT_CARDS)

    elseif csid == 199 and option == 0 then
        player:incrementCharVar('RubbishDay_prog', 1)
        player:setCharVar('RubbishDay_day', VanadielDayOfTheYear()) -- new vanadiel day

    elseif csid == 198 and option == 0 then
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.RUBBISH_DAY)
        npcUtil.giveKeyItem(player, xi.ki.MAGIC_TRASH)
        player:setCharVar('RubbishDay_prog', 0)
        player:setCharVar('RubbishDay_day', VanadielDayOfTheYear())

    elseif
        (csid == 10110 or csid == 10112 or csid == 10113) and
        option == 0
    then -- ALL_IN_THE_CARDS started, repeated, or additional cards given
        local rand = math.random(1, 4)
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
            player:setCharVar('AllInTheCards_date', getMidnight())
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
            player:confirmTrade()
        end

    elseif csid == 197 then
        npcUtil.completeQuest(player, xi.questLog.JEUNO, xi.quest.id.jeuno.RUBBISH_DAY, {
            gil = 6000,
            item = xi.item.CHAIN_CHOKER,
            var = { 'RubbishDayVar' }
        })
    end
end

return entity
