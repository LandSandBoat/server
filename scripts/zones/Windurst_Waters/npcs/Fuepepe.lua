-----------------------------------
-- Area: Windurst Waters
--  NPC: Fuepepe
-- Starts and Finishes Quest: Teacher's Pet
-- Involved in Quest: Making the grade, Class Reunion
-- !pos 161 -2 161 238
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_THE_GRADE) == QUEST_ACCEPTED and
        player:getCharVar("QuestMakingTheGrade_prog") == 0 and
        npcUtil.tradeHas(trade, 544)
    then
        player:startEvent(455) -- Quest Progress: Test Papers Shown and told to deliver them to principal
    end
end

entity.onTrigger = function(player, npc)
    local teachersPet = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TEACHER_S_PET)
    local makingTheGrade = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_THE_GRADE)
    local letSleepingDogsLie = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.LET_SLEEPING_DOGS_LIE)
    local classReunion = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CLASS_REUNION)

    -- MAKING THE GRADE
    if
        teachersPet == QUEST_COMPLETED and
        makingTheGrade == QUEST_AVAILABLE and
        player:getFameLevel(WINDURST) >= 3 and
        letSleepingDogsLie ~= QUEST_ACCEPTED
    then
        player:startEvent(442)
    elseif makingTheGrade == QUEST_ACCEPTED then
        -- 1 = answers found
        -- 2 = gave test answers to principle
        -- 3 = spoke to chomoro
        local makingTheGradeProg = player:getCharVar("QuestMakingTheGrade_prog")

        if makingTheGradeProg == 0 then
            player:startEvent(443) -- Get Test Sheets Reminder
        elseif makingTheGradeProg == 1 then
            player:startEvent(456) -- Deliver Test Sheets Reminder
        elseif makingTheGradeProg == 2 or makingTheGradeProg == 3 then
            player:startEvent(458) -- Quest Finish
        end
    elseif makingTheGrade == QUEST_COMPLETED and player:needToZone() then
        player:startEvent(459)

    -- CLASS REUNION
    elseif
        classReunion == QUEST_ACCEPTED and
        player:getCharVar("ClassReunionProgress") >= 3 and
        player:getCharVar("ClassReunion_TalkedToFupepe") ~= 1
    then
        player:startEvent(817) -- he tells you about Uran-Mafran

    -- DEFAULT DIALOG
    else
        player:startEvent(423)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 442 and option == 1 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_THE_GRADE)
    elseif csid == 455 then -- Quest Progress: Test Papers Shown and told to deliver them to principal
        player:setCharVar("QuestMakingTheGrade_prog", 1)
    elseif
        csid == 458 and
        npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.MAKING_THE_GRADE, {
            item = 4855,
            fame = 75,
            var = "QuestMakingTheGrade_prog",
        })
    then
        player:needToZone(true)
    elseif csid == 817 then
        player:setCharVar("ClassReunion_TalkedToFupepe", 1)
    end
end

return entity
