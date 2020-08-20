-----------------------------------
-- Area: Windurst Woods
--  NPC: Kopuro-Popuro
-- Type: Standard NPC
-- !pos -0.037 -4.749 -22.589 241
-- Starts Quests: The All-New C-2000, Legendary Plan B, The All-New C-3000
-- Involved in quests: Lost Chick
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    local allNewC2000 = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_ALL_NEW_C_2000)
    local legendaryPlanB = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LEGENDARY_PLAN_B)
    local allNewC3000 = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_ALL_NEW_C_3000)

    -- THE ALL NEW C-2000
    if allNewC2000 == QUEST_ACCEPTED then
        if npcUtil.tradeHas(trade, {846, 856, 4368}) then
            player:startEvent(292, GIL_RATE * 200) -- Correct items given, complete quest.
        else
            player:startEvent(288, 0, 856, 846, 4368) -- Incorrect or not enough items.
        end

    -- LEGENDARY PLAN B
    elseif legendaryPlanB == QUEST_ACCEPTED then
        if npcUtil.tradeHas(trade, {529, 858, 940}) then
            player:startEvent(314, 0, 529, 940, 858) -- Correct items given, complete quest in onEventUpdate
        else
            player:startEvent(309, 0, 529, 940, 858) -- Incorrect or not enough items
        end

    -- THE ALL NEW C-3000
    elseif allNewC3000 == QUEST_ACCEPTED or allNewC3000 == QUEST_COMPLETED then
        if npcUtil.tradeHas(trade, {889, 939}) then
            player:startEvent(657, 0, 889, 939) -- Correct items given, complete quest in onEventUpdate
        else
            player:startEvent(656, 0, 889, 939) -- Incorrect or not enough items
        end

    end
end

function onTrigger(player, npc)
    local allNewC2000 = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_ALL_NEW_C_2000)
    local aGreetingCardian = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.A_GREETING_CARDIAN)
    local aGreetingCardianCS = player:getCharVar("AGreetingCardian_Event")
    local legendaryPlanB = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LEGENDARY_PLAN_B)
    local allNewC3000 = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_ALL_NEW_C_3000)

    -- THE ALL NEW C-3000
    if legendaryPlanB == QUEST_COMPLETED and allNewC3000 == QUEST_AVAILABLE and player:getFameLevel(WINDURST) >= 4 then
        if player:needToZone() then
            player:startEvent(316) -- Post quest text from legendaryPlanB
        else
            player:startEvent(655, 0, 889, 939)
        end
    elseif allNewC3000 == QUEST_COMPLETED then
        player:startEvent(659, 0, 889, 939)

    -- A GREETING CARDIAN
    elseif aGreetingCardian == QUEST_ACCEPTED and aGreetingCardianCS == 5 then
        player:startEvent(301) -- Supplemental text when aGreetingCardian in progress, right before completion

    -- LEGENDARY PLAN B
    elseif aGreetingCardian == QUEST_COMPLETED and legendaryPlanB == QUEST_AVAILABLE and player:getFameLevel(WINDURST) >= 3 then
        if player:needToZone() then
            player:startEvent(306) -- Supplemental text for aGreetingCardian before start of legendaryPlanB
        else
            player:startEvent(308, 0, 529, 940, 858) -- legendaryPlanB start
        end
    elseif legendaryPlanB == QUEST_ACCEPTED then
        player:startEvent(309, 0, 529, 940, 858) -- legendaryPlanB reminder
    elseif legendaryPlanB == QUEST_COMPLETED then
        player:startEvent(316)

    -- THE ALL NEW C-2000
    elseif allNewC2000 == QUEST_AVAILABLE then
        player:startEvent(285, 0, 856, 846, 4368) -- Start Quest
    elseif allNewC2000 == QUEST_ACCEPTED then
        player:startEvent(288, 0, 856, 846, 4368) -- Reminder Dialogue
    elseif allNewC2000 == QUEST_COMPLETED then
        player:startEvent(293) -- Post Quest Finish Text

    -- STANDARD DIALOG
    else
        player:startEvent(276)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- THE ALL NEW C-2000
    if csid == 285 and option ~= 2 then  -- option 2 is declining the quest for the second question
        player:addQuest(WINDURST, tpz.quest.id.windurst.THE_ALL_NEW_C_2000)
    elseif csid == 292 and npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.THE_ALL_NEW_C_2000, {fame=80, title=tpz.title.CARDIAN_TUTOR, gil=200}) then
        player:confirmTrade()

    -- LEGENDARY PLAN B
    elseif csid == 308 then
        player:addQuest(WINDURST, tpz.quest.id.windurst.LEGENDARY_PLAN_B)
    elseif csid == 314 and npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.LEGENDARY_PLAN_B, {item=12749, gil=700}) then
        player:confirmTrade()
        player:needToZone(true)

    -- THE ALL NEW C-3000
    elseif csid == 655 then
        player:addQuest(WINDURST, tpz.quest.id.windurst.THE_ALL_NEW_C_3000)
    elseif csid == 657 and npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.THE_ALL_NEW_C_3000, {fame=10, gil=600}) then
        player:confirmTrade()
    end
end
