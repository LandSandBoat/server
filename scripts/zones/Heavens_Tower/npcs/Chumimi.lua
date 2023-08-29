-----------------------------------
-- Area: Heaven's Tower
--  NPC: Chumimi
-- Starts and Finishes Quest: The Three Magi, Recollections
-- !pos 0.1 30 21 242
-----------------------------------
local ID = zones[xi.zone.HEAVENS_TOWER]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_THREE_MAGI) == QUEST_ACCEPTED and
        trade:hasItemQty(xi.item.GLOWSTONE, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(269) -- Finish Quest "The Three Magi"
    elseif
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.RECOLLECTIONS) == QUEST_ACCEPTED and
        player:getCharVar('recollectionsQuest') < 2 and
        trade:hasItemQty(xi.item.BAG_OF_SEEDS, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(271, 0, 520)
    elseif
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM) == QUEST_ACCEPTED and
        player:getCharVar('rootProblem') == 1 and
        trade:hasItemQty(xi.item.SQUARE_OF_SILK_CLOTH, 1) and
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
        player:startEvent(260, 0, 613, 0, 0, 0, xi.item.GLOWSTONE) -- Start Quest "The Three Magi" --- NOTE: 5th parameter is "Meteorites" but he doesn't exist ---
    elseif theThreeMagi == QUEST_ACCEPTED then
        player:startEvent(261, 0, 0, 0, 0, 0, xi.item.GLOWSTONE) -- During Quest "The Three Magi"
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
        player:startEvent(270, 0, xi.item.BAG_OF_SEEDS) -- Start Quest "Recollections"
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
        player:startEvent(276, 0, xi.item.SQUARE_OF_SILK_CLOTH) -- Start Quest "The Root of The problem"
    elseif rootProblem == QUEST_ACCEPTED then
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

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 260 then
        -- option 3: Koru-Moru -- option 2: Shantotto -- option 1: Yoran-Oran
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_THREE_MAGI)
        player:setCharVar('theThreeMagiSupport', option)
    elseif csid == 269 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.CASTING_WAND) -- Casting Wand
        else
            local choosetitle = player:getCharVar('theThreeMagiSupport')

            if choosetitle == 3 then
                player:addTitle(xi.title.PROFESSOR_KORU_MORU_SUPPORTER)
            elseif choosetitle == 2 then
                player:addTitle(xi.title.DOCTOR_SHANTOTTO_SUPPORTER)
            else
                player:addTitle(xi.title.DOCTOR_YORAN_ORAN_SUPPORTER)
            end

            player:tradeComplete()
            player:addItem(xi.item.CASTING_WAND)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.CASTING_WAND) -- Casting Wand
            player:needToZone(true)
            player:setCharVar('theThreeMagiSupport', 0)
            player:addFame(xi.quest.fame_area.WINDURST, 20)
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_THREE_MAGI)
        end
    elseif csid == 270 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.RECOLLECTIONS)
    elseif csid == 271 then
        player:tradeComplete()
        player:setCharVar('recollectionsQuest', 2)
    elseif csid == 275 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.WIZARDS_SABOTS) -- wizards sabots
        else
            player:setCharVar('recollectionsQuest', 0)
            player:delKeyItem(xi.ki.FOE_FINDER_MK_I)
            player:addItem(xi.item.WIZARDS_SABOTS)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.WIZARDS_SABOTS) -- wizards sabots
            player:addFame(xi.quest.fame_area.WINDURST, 40)
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.RECOLLECTIONS)
        end
    elseif csid == 276 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM)
        player:setCharVar('rootProblem', 1)
    elseif csid == 279 then
        player:addKeyItem(xi.ki.SLUICE_SURVEYOR_MK_I)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SLUICE_SURVEYOR_MK_I)
    elseif csid == 281 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
        else
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM)
            player:addItem(xi.item.WIZARDS_PETASOS)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.WIZARDS_PETASOS)
            player:addTitle(xi.title.PARAGON_OF_BLACK_MAGE_EXCELLENCE)
            player:delKeyItem(xi.ki.SLUICE_SURVEYOR_MK_I)
        end
    end
end

return entity
