-----------------------------------
-- Area: Windurst Waters
--  NPC: Fuepepe
-- Starts and Finishes Quest: Teacher's Pet
-- Involved in Quest: Making the grade, Class Reunion
-- !pos 161 -2 161 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_THE_GRADE) == QUEST_ACCEPTED and player:getCharVar("QuestMakingTheGrade_prog") == 0) then
        if (trade:hasItemQty(544, 1) and trade:getItemCount() == 1 and trade:getGil() == 0) then
            player:startEvent(455) -- Quest Progress: Test Papers Shown and told to deliver them to principal
        end
    end
end

function onTrigger(player, npc)

    local gradestatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_THE_GRADE)
    local prog = player:getCharVar("QuestMakingTheGrade_prog")
        -- 1 = answers found
        -- 2 = gave test answers to principle
        -- 3 = spoke to chomoro

    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TEACHER_S_PET) == QUEST_COMPLETED and gradestatus == QUEST_AVAILABLE and player:getFameLevel(WINDURST) >=3 and player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LET_SLEEPING_DOGS_LIE) ~= QUEST_ACCEPTED) then
        player:startEvent(442) -- Quest Start
    elseif (gradestatus == QUEST_ACCEPTED) then

        if (prog == 0) then
                player:startEvent(443) -- Get Test Sheets Reminder
        elseif (prog == 1) then
            player:startEvent(456) -- Deliver Test Sheets Reminder
        elseif (prog == 2 or prog == 3) then
            player:startEvent(458) -- Quest Finish
        end
    elseif (gradestatus == QUEST_COMPLETED and player:needToZone() == true) then
        player:startEvent(459) -- After Quest
    -------------------------------------------------------
    -- Class Reunion
    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CLASS_REUNION) == QUEST_ACCEPTED and player:getCharVar("ClassReunionProgress") >= 3 and player:getCharVar("ClassReunion_TalkedToFupepe") ~= 1) then
        player:startEvent(817) -- he tells you about Uran-Mafran
    -------------------------------------------------------
    else
        player:startEvent(423) -- Standard Conversation
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 442 and option == 1) then -- Quest Start
        player:addQuest(WINDURST, tpz.quest.id.windurst.MAKING_THE_GRADE)
    elseif (csid == 455) then -- Quest Progress: Test Papers Shown and told to deliver them to principal
        player:setCharVar("QuestMakingTheGrade_prog", 1)
    elseif (csid == 458) then -- Quest Finish
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4855)
        else
            player:tradeComplete()
            player:completeQuest(WINDURST, tpz.quest.id.windurst.MAKING_THE_GRADE)
            player:addFame(WINDURST, 75)
            player:addItem(4855)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4855)
            player:setCharVar("QuestMakingTheGrade_prog", 0)
            player:needToZone(true)
        end
    elseif (csid == 817) then
        player:setCharVar("ClassReunion_TalkedToFupepe", 1)
    end
end
