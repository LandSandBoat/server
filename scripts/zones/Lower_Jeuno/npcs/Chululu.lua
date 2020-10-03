-----------------------------------
-- Area: Lower Jeuno
--  NPC: Chululu
-- Starts and Finishes Quests: Collect Tarut Cards, Rubbish Day, All in the Cards
-- Optional Cutscene at end of Quest: Searching for the Right Words
-- !pos -13 -6 -42 245
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.COLLECT_TARUT_CARDS) == QUEST_ACCEPTED then
        if npcUtil.tradeHas(trade, {558, 559, 561, 562}, true) then
            player:startEvent(200) -- Finish quest "Collect Tarut Cards"
        end
    elseif player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.ALL_IN_THE_CARDS) >= QUEST_ACCEPTED then
        if npcUtil.tradeHas(trade, {558, 559, 561, 562}, true) then
            player:startEvent(10114) -- Finish quest "All in the Cards"
        end
    end
end

function onTrigger(player, npc)
    local CollectTarutCards = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.COLLECT_TARUT_CARDS)
    local RubbishDay = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RUBBISH_DAY)
    local SearchingForTheRightWords = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.SEARCHING_FOR_THE_RIGHT_WORDS)
    local AllInTheCards = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.ALL_IN_THE_CARDS)
    local cdate = player:getCharVar("AllInTheCards_date")

    if player:getFameLevel(JEUNO) >= 3 and CollectTarutCards == QUEST_AVAILABLE then
        player:startEvent(28) -- Start quest "Collect Tarut Cards" with option
    elseif CollectTarutCards == QUEST_ACCEPTED then
        player:startEvent(27) -- During quest "Collect Tarut Cards"
    elseif CollectTarutCards == QUEST_COMPLETED and RubbishDay == QUEST_AVAILABLE and
        player:getCharVar("RubbishDay_day") ~= VanadielDayOfTheYear() then
        --      prog = player:getCharVar("RubbishDay_prog")
        --      if (prog <= 2) then
        --          player:startEvent(199) -- Required to get compatibility 3x on 3 diff game days before quest is kicked off
        --      elseif (prog == 3) then
        player:startEvent(198) -- Start quest "Rubbish Day" with option
        --      end
    elseif CollectTarutCards == QUEST_COMPLETED and RubbishDay == QUEST_AVAILABLE then
        player:startEvent(57) -- Standard dialog between 2 quests
    elseif RubbishDay == QUEST_ACCEPTED and player:getCharVar("RubbishDayVar") == 0 then
        player:startEvent(49) -- During quest "Rubbish Day"
    elseif RubbishDay == QUEST_ACCEPTED and player:getCharVar("RubbishDayVar") == 1 then
        player:startEvent(197) -- Finish quest "Rubbish Day"
    elseif player:getFameLevel(JEUNO) >= 4 and CollectTarutCards == QUEST_COMPLETED and AllInTheCards == QUEST_AVAILABLE then
        player:startEvent(10110) -- Start quest "All in the Cards" with option
    elseif AllInTheCards >= QUEST_ACCEPTED and player:getLocalVar("Cardstemp") == 0 then
        if cdate >= os.time() then
            player:startEvent(10111) -- During quest "All in the Cards" and same AllInTheCards_date value
        elseif cdate == 0 then
            player:startEvent(10113) -- Start quest "All in the Cards"	repeat with option
        elseif cdate < os.time() then
            player:startEvent(10112) -- During quest "All in the Cards"  THIS ONE GIVES ANOTHER BATCH
        end
    elseif SearchingForTheRightWords == QUEST_COMPLETED then
        if player:getCharVar("SearchingForRightWords_postcs") < -1 then
            player:startEvent(56)
        else
            player:startEvent(57) -- final state, after all quests complete
        end
    elseif RubbishDay == QUEST_COMPLETED then
        player:startEvent(57) -- New standard dialog
    else
        player:startEvent(26) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 28 and option == 0 then
        local rand = math.random(1, 4)
        local card = 0

        if (rand == 1) then
            card = 559 -- Tarut: Death
        elseif (rand == 2) then
            card = 562 -- Tarut: Hermit
        elseif (rand == 3) then
            card = 561 -- Tarut: King
        else
            card = 558 -- Tarut: Fool
        end

        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, card)
        else
            player:addQuest(JEUNO, tpz.quest.id.jeuno.COLLECT_TARUT_CARDS)
            player:addItem(card, 5)
            player:messageSpecial(ID.text.ITEM_OBTAINED, card)
        end
    elseif (csid == 200) then
        player:addTitle(tpz.title.CARD_COLLECTOR)
        player:addFame(JEUNO, 30)
        player:tradeComplete()
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.COLLECT_TARUT_CARDS)
    elseif (csid == 199 and option == 0) then
        player:addCharVar("RubbishDay_prog", 1)
        player:setCharVar("RubbishDay_day", VanadielDayOfTheYear()) -- new vanadiel day
    elseif (csid == 198 and option == 0) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.RUBBISH_DAY)
        player:addKeyItem(tpz.ki.MAGIC_TRASH)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MAGIC_TRASH)
        player:setCharVar("RubbishDay_prog", 0)
        player:setCharVar("RubbishDay_day", VanadielDayOfTheYear())
    elseif (csid == 10110 or csid == 10112 or csid == 10113) and option == 0 then -- ALL_IN_THE_CARDS started, repeated, or additional cards given
        local rand = math.random(1, 4)
        local card = 0

        if (rand == 1) then
            card = 559 -- Tarut: Death
        elseif (rand == 2) then
            card = 562 -- Tarut: Hermit
        elseif (rand == 3) then
            card = 561 -- Tarut: King
        else
            card = 558 -- Tarut: Fool
        end

        if npcUtil.giveItem(player, {{card, 5}}) then
            player:addQuest(JEUNO, tpz.quest.id.jeuno.ALL_IN_THE_CARDS)
            player:setCharVar("AllInTheCards_date", getMidnight())
            player:setLocalVar("Cardstemp", 1)
        end
    elseif csid == 10111 then -- same day, have to return later
        player:setLocalVar("Cardstemp", 1)
    elseif csid == 10114 then
        if npcUtil.completeQuest(player, JEUNO, tpz.quest.id.jeuno.ALL_IN_THE_CARDS, {
            gil = 600,
            title = tpz.title.CARD_COLLECTOR,
            var = {"AllInTheCards_date"}
        }) then
            trade:confirm()
        end
    elseif csid == 197 then
        npcUtil.completeQuest(player, JEUNO, tpz.quest.id.jeuno.RUBBISH_DAY, {
            gil = 6000,
            item = 13083,
            var = {"RubbishDayVar"}
        })
    end
end
