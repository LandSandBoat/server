-----------------------------------
-- Area: Heaven's Tower
--  NPC: Chumimi
-- Starts and Finishes Quest: The Three Magi, Recollections
-- !pos 0.1 30 21 242
-----------------------------------
local ID = require("scripts/zones/Heavens_Tower/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_THREE_MAGI) == QUEST_ACCEPTED and
        trade:hasItemQty(1104, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(269) -- Finish Quest "The Three Magi"
    elseif
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.RECOLLECTIONS) == QUEST_ACCEPTED and
        player:getCharVar("recollectionsQuest") < 2 and
        trade:hasItemQty(1105, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(271, 0, 520)
    elseif
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM) == QUEST_ACCEPTED and
        player:getCharVar("rootProblem") == 1 and
        trade:hasItemQty(829, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(278)
    end
end

entity.onTrigger = function(player, npc)
    local theThreeMagi = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_THREE_MAGI)
    local recollections = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.RECOLLECTIONS)
    local rootProblem = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM)
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()

    if
        theThreeMagi == QUEST_AVAILABLE and
        mJob == xi.job.BLM and
        mLvl >= xi.settings.main.AF1_QUEST_LEVEL
    then
        player:startEvent(260, 0, 613, 0, 0, 0, 1104) -- Start Quest "The Three Magi" --- NOTE: 5th parameter is "Meteorites" but he doesn't exist ---
    elseif theThreeMagi == QUEST_ACCEPTED then
        player:startEvent(261, 0, 0, 0, 0, 0, 1104) -- During Quest "The Three Magi"
    elseif
        theThreeMagi == QUEST_COMPLETED and
        recollections == QUEST_AVAILABLE and
        (mJob == xi.job.BLM and mLvl < xi.settings.main.AF2_QUEST_LEVEL or mJob ~= xi.job.BLM)
    then
        player:startEvent(268) -- New standard dialog after "The Three Magi"
    elseif
        theThreeMagi == QUEST_COMPLETED and
        mJob == xi.job.BLM and
        mLvl >= xi.settings.main.AF2_QUEST_LEVEL and
        not player:needToZone() and
        recollections == QUEST_AVAILABLE
    then
        player:startEvent(270, 0, 1105) -- Start Quest "Recollections"
    elseif
        recollections == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.FOE_FINDER_MK_I)
    then
        player:startEvent(275) -- Finish Quest "Recollections"
    elseif
        recollections == QUEST_COMPLETED and
        rootProblem == QUEST_AVAILABLE and
        mJob == xi.job.BLM and
        mLvl >= 50 and
        not player:needToZone()
    then
        player:startEvent(276, 0, 829) -- Start Quest "The Root of The problem"
    elseif rootProblem == QUEST_ACCEPTED then
        local rootProblemCS = player:getCharVar("rootProblem")

        if rootProblemCS == 1 then
            player:startEvent(277, 0, 829)
        elseif rootProblemCS == 2 then
            player:startEvent(279)
        elseif rootProblemCS == 3 then
            player:startEvent(281)
        end
    else
        player:startEvent(259) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 260 then
        -- option 3: Koru-Moru -- option 2: Shantotto -- option 1: Yoran-Oran
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_THREE_MAGI)
        player:setCharVar("theThreeMagiSupport", option)
    elseif csid == 269 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17423) -- Casting Wand
        else
            local choosetitle = player:getCharVar("theThreeMagiSupport")

            if choosetitle == 3 then
                player:addTitle(xi.title.PROFESSOR_KORU_MORU_SUPPORTER)
            elseif choosetitle == 2 then
                player:addTitle(xi.title.DOCTOR_SHANTOTTO_SUPPORTER)
            else
                player:addTitle(xi.title.DOCTOR_YORAN_ORAN_SUPPORTER)
            end

            player:tradeComplete()
            player:addItem(17423)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17423) -- Casting Wand
            player:needToZone(true)
            player:setCharVar("theThreeMagiSupport", 0)
            player:addFame(xi.quest.fame_area.WINDURST, 20)
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_THREE_MAGI)
        end
    elseif csid == 270 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.RECOLLECTIONS)
    elseif csid == 271 then
        player:tradeComplete()
        player:setCharVar("recollectionsQuest", 2)
    elseif csid == 275 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 14092) -- wizards sabots
        else
            player:setCharVar("recollectionsQuest", 0)
            player:delKeyItem(xi.ki.FOE_FINDER_MK_I)
            player:addItem(14092)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 14092) -- wizards sabots
            player:addFame(xi.quest.fame_area.WINDURST, 40)
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.RECOLLECTIONS)
        end
    elseif csid == 276 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM)
        player:setCharVar("rootProblem", 1)
    elseif csid == 279 then
        player:addKeyItem(xi.ki.SLUICE_SURVEYOR_MK_I)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SLUICE_SURVEYOR_MK_I)
    elseif csid == 281 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
        else
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM)
            player:addItem(13856)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13856)
            player:addTitle(xi.title.PARAGON_OF_BLACK_MAGE_EXCELLENCE)
            player:delKeyItem(xi.ki.SLUICE_SURVEYOR_MK_I)
        end
    end
end

return entity
