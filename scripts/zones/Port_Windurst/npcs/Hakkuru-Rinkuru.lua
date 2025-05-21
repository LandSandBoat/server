-----------------------------------
-- Area: Port Windurst
--  NPC: Hakkuru-Rinkuru
-- Involved In Quest: Making Amends
-- Starts and Ends Quest: Wonder Wands
-- !pos -111 -4 101 240
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_AMENDS) == xi.questStatus.QUEST_ACCEPTED then
        if
            trade:hasItemQty(xi.item.BLOCK_OF_ANIMAL_GLUE, 1) and
            trade:getItemCount() == 1
        then
            player:startEvent(277, 1500)
        else
            player:startEvent(275, 0, xi.item.BLOCK_OF_ANIMAL_GLUE)
        end
    elseif player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.WONDER_WANDS) == xi.questStatus.QUEST_ACCEPTED then
        if
            trade:hasItemQty(xi.item.OAK_STAFF, 1) and
            trade:hasItemQty(xi.item.MYTHRIL_ROD, 1) and
            trade:hasItemQty(xi.item.ROSE_WAND, 1) and
            trade:getItemCount() == 3
        then
            -- Check that all 3 items have been traded, one each
            player:setCharVar('SecondRewardVar', 1)
            player:startEvent(265, 0, xi.item.OAK_STAFF, xi.item.MYTHRIL_ROD, xi.item.ROSE_WAND) -- Completion of quest cutscene for Wondering Wands
        else
            player:startEvent(260, 0, xi.item.OAK_STAFF, xi.item.MYTHRIL_ROD, xi.item.ROSE_WAND) -- Remind player which items are needed ifquest is accepted and items are not traded
        end
    end
end

entity.onTrigger = function(player, npc)
    local makingAmends = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_AMENDS)
    local makingAmens  = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_AMENS) --Second quest in series
    local wonderWands  = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.WONDER_WANDS) --Third and final quest in series
    local needToZone   = player:needToZone()
    local pFame        = player:getFameLevel(xi.fameArea.WINDURST)

-- Begin Making Amends Section
    if makingAmends == xi.questStatus.QUEST_AVAILABLE and pFame >= 2 then
            player:startEvent(274, 0, xi.item.BLOCK_OF_ANIMAL_GLUE) -- MAKING AMENDS + ANIMAL GLUE: Quest Start
    elseif makingAmends == xi.questStatus.QUEST_ACCEPTED then
            player:startEvent(275, 0, xi.item.BLOCK_OF_ANIMAL_GLUE) -- MAKING AMENDS + ANIMAL GLUE: Quest Objective Reminder
    elseif makingAmends == xi.questStatus.QUEST_COMPLETED and needToZone then
            player:startEvent(278) -- MAKING AMENDS: After Quest
--End Making Amends Section; Begin Wonder Wands Section
    elseif
        makingAmends == xi.questStatus.QUEST_COMPLETED and
        makingAmens == xi.questStatus.QUEST_COMPLETED and
        wonderWands == xi.questStatus.QUEST_AVAILABLE and
        pFame >= 5 and
        not needToZone
    then
            player:startEvent(259) --Starts Wonder Wands
    elseif wonderWands == xi.questStatus.QUEST_ACCEPTED then
            player:startEvent(260) --Reminder for Wonder Wands
    elseif wonderWands == xi.questStatus.QUEST_COMPLETED then
        if player:getCharVar('SecondRewardVar') == 1 then
            player:startEvent(267) --Initiates second reward ifWonder Wands has been completed.
        end
    end
-- End Wonder Wands Section
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 274 and option == 1 then
            player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_AMENDS)
    elseif csid == 277 then
            player:addGil(xi.settings.main.GIL_RATE * 1500)
            player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_AMENDS)
            player:addFame(xi.fameArea.WINDURST, 75)
            player:addTitle(xi.title.QUICK_FIXER)
            player:needToZone(true)
            player:tradeComplete()
    elseif csid == 259 and option == 1 then
            player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.WONDER_WANDS)
    elseif csid == 267 then
        local rand = math.random(1, 3) --Setup random variable to determine which 2 items are returned upon quest completion
        if rand == 1 then
            if player:getFreeSlotsCount() == 1 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MYTHRIL_ROD)
            elseif player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.OAK_STAFF)
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MYTHRIL_ROD)
            else
                player:addItem(xi.item.OAK_STAFF, 1)
                player:addItem(xi.item.MYTHRIL_ROD, 1) --Returns the Oak Staff and the Mythril Rod
                player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.OAK_STAFF)
                player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.MYTHRIL_ROD)
                player:setCharVar('SecondRewardVar', 0)
            end
        elseif rand == 2 then
            if player:getFreeSlotsCount() == 1 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ROSE_WAND)
            elseif player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.OAK_STAFF)
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ROSE_WAND)
            else
                player:addItem(xi.item.OAK_STAFF, 1)
                player:addItem(xi.item.ROSE_WAND, 1) --Returns the Oak Staff and the Rose Wand
                player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.OAK_STAFF)
                player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.ROSE_WAND)
                player:setCharVar('SecondRewardVar', 0)
            end
        elseif rand == 3 then
            if player:getFreeSlotsCount() == 1 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ROSE_WAND)
            elseif player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MYTHRIL_ROD)
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ROSE_WAND)
            else
                player:addItem(xi.item.MYTHRIL_ROD, 1)
                player:addItem(xi.item.ROSE_WAND, 1) --Returns the Rose Wand and the Mythril Rod
                player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.MYTHRIL_ROD)
                player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.ROSE_WAND)
                player:setCharVar('SecondRewardVar', 0)
            end
        end
    elseif csid == 265 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.NEW_MOON_ARMLETS)
        else
            player:tradeComplete()
            npcUtil.giveCurrency(player, 'gil', 4800)
            player:addItem(xi.item.NEW_MOON_ARMLETS)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.NEW_MOON_ARMLETS)
            player:addFame(xi.fameArea.WINDURST, 150)
            player:addTitle(xi.title.DOCTOR_SHANTOTTOS_GUINEA_PIG)
            player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.WONDER_WANDS)
        end
    end
end

return entity
