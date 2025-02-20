-----------------------------------
-- Area: Heaven's Tower
--  NPC: Chumimi
-- Starts and Finishes Quest: The Three Magi, Recollections
-- !pos 0.1 30 21 242
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_THREE_MAGI) == xi.questStatus.QUEST_ACCEPTED and
        trade:hasItemQty(xi.item.GLOWSTONE, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(269) -- Finish Quest "The Three Magi"
    elseif
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.RECOLLECTIONS) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('recollectionsQuest') < 2 and
        trade:hasItemQty(xi.item.BAG_OF_SEEDS, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(271, 0, 520)
    elseif
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('rootProblem') == 1 and
        trade:hasItemQty(xi.item.SQUARE_OF_SILK_CLOTH, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(278)
    end
end

entity.onTrigger = function(player, npc)
    local theThreeMagi = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_THREE_MAGI)
    local recollections = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.RECOLLECTIONS)
    local rootProblem = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM)
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()

    if
        theThreeMagi == xi.questStatus.QUEST_AVAILABLE and
        mJob == xi.job.BLM and
        mLvl >= xi.settings.main.AF1_QUEST_LEVEL
    then
        player:startEvent(260, 0, 613, 0, 0, 0, xi.item.GLOWSTONE) -- Start Quest "The Three Magi" --- NOTE: 5th parameter is "Meteorites" but he doesn't exist ---
    elseif theThreeMagi == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(261, 0, 0, 0, 0, 0, xi.item.GLOWSTONE) -- During Quest "The Three Magi"
    elseif
        theThreeMagi == xi.questStatus.QUEST_COMPLETED and
        recollections == xi.questStatus.QUEST_AVAILABLE and
        (mJob == xi.job.BLM and mLvl < xi.settings.main.AF2_QUEST_LEVEL or mJob ~= xi.job.BLM)
    then
        player:startEvent(268) -- New standard dialog after "The Three Magi"
    elseif
        theThreeMagi == xi.questStatus.QUEST_COMPLETED and
        mJob == xi.job.BLM and
        mLvl >= xi.settings.main.AF2_QUEST_LEVEL and
        not player:needToZone() and
        recollections == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(270, 0, xi.item.BAG_OF_SEEDS) -- Start Quest "Recollections"
    elseif
        recollections == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.FOE_FINDER_MK_I)
    then
        player:startEvent(275) -- Finish Quest "Recollections"
    elseif
        recollections == xi.questStatus.QUEST_COMPLETED and
        rootProblem == xi.questStatus.QUEST_AVAILABLE and
        mJob == xi.job.BLM and
        mLvl >= 50 and
        not player:needToZone()
    then
        player:startEvent(276, 0, xi.item.SQUARE_OF_SILK_CLOTH) -- Start Quest "The Root of The problem"
    elseif rootProblem == xi.questStatus.QUEST_ACCEPTED then
        local rootProblemCS = player:getCharVar('rootProblem')

        if rootProblemCS == 1 then
            player:startEvent(277, 0, xi.item.SQUARE_OF_SILK_CLOTH)
        elseif rootProblemCS == 2 then
            player:startEvent(279)
        elseif rootProblemCS == 3 then
            player:startEvent(281)
        end
    else
        player:startEvent(259) -- Standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 260 then
        -- option 3: Koru-Moru -- option 2: Shantotto -- option 1: Yoran-Oran
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.THE_THREE_MAGI)
        player:setCharVar('theThreeMagiSupport', option)
    elseif csid == 269 then
        if npcUtil.giveItem(player, xi.item.CASTING_WAND) then
            local choosetitle = player:getCharVar('theThreeMagiSupport')

            if choosetitle == 3 then
                player:addTitle(xi.title.PROFESSOR_KORU_MORU_SUPPORTER)
            elseif choosetitle == 2 then
                player:addTitle(xi.title.DOCTOR_SHANTOTTO_SUPPORTER)
            else
                player:addTitle(xi.title.DOCTOR_YORAN_ORAN_SUPPORTER)
            end

            player:tradeComplete()
            player:needToZone(true)
            player:setCharVar('theThreeMagiSupport', 0)
            player:addFame(xi.fameArea.WINDURST, 20)
            player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.THE_THREE_MAGI)
        end
    elseif csid == 270 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.RECOLLECTIONS)
    elseif csid == 271 then
        player:tradeComplete()
        player:setCharVar('recollectionsQuest', 2)
    elseif csid == 275 then
        if npcUtil.giveItem(player, xi.item.WIZARDS_SABOTS) then
            player:setCharVar('recollectionsQuest', 0)
            player:delKeyItem(xi.ki.FOE_FINDER_MK_I)
            player:addFame(xi.fameArea.WINDURST, 40)
            player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.RECOLLECTIONS)
        end
    elseif csid == 276 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM)
        player:setCharVar('rootProblem', 1)
    elseif csid == 279 then
        npcUtil.giveKeyItem(player, xi.ki.SLUICE_SURVEYOR_MK_I)
    elseif csid == 281 then
        if npcUtil.giveItem(player, xi.item.WIZARDS_PETASOS) then
            player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM)
            player:addTitle(xi.title.PARAGON_OF_BLACK_MAGE_EXCELLENCE)
            player:delKeyItem(xi.ki.SLUICE_SURVEYOR_MK_I)
        end
    end
end

return entity
