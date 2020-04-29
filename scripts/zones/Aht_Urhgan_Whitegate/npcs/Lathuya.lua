 -----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Lathuya
-- Standard Info NPC
-- Involved in quests: Omens
-- !pos -95.081 -6.000 31.638 50
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------

local craftingItems = {
-- itemBit = {firstItem, secondItem, thirdItem, fourthItem, coinType, coinAmmount, craftedItem, optionId}
    [1] = {754,  828,  879, 4158, 2186, 2, 14928, 1}, -- magus bazubands
    [2] = {761,  828, 2175, 2340, 2186, 2, 15600, 2}, -- magus shalwar
    [4] = {828, 2229, 2288, 2340, 2186, 4, 14521, 3}  -- magus jubbah
}

function onTrade(player, npc, trade)
    local currentTask = player:getCharVar("LathuyaCurrentTask_Mask")
    local craftingBluArmor = player:getCharVar("CraftingBluArmor")
    local totalCraftedPieces = player:countMaskBits(player:getCharVar("LathuyaCraftingList_Mask"))
    local csOffset = 8 * totalCraftedPieces

    if craftingBluArmor == 0  and npcUtil.tradeHasExactly(trade, {
        craftingItems[currentTask][1], craftingItems[currentTask][2], craftingItems[currentTask][3], craftingItems[currentTask][4]
    }) then
        player:startEvent(732 + csOffset, craftingItems[currentTask][7], craftingItems[currentTask][5], craftingItems[currentTask][6])
    elseif craftingBluArmor == 1 and npcUtil.tradeHasExactly(trade, {
        {craftingItems[currentTask][5], craftingItems[currentTask][6]}
    }) then
        player:startEvent(734 + csOffset, 0, craftingItems[currentTask][5], craftingItems[currentTask][6])
   end
end

function onTrigger(player, npc)
    local omensProgress = player:getCharVar("OmensProgress")
    local omens = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.OMENS)
    local transformations = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.TRANSFORMATIONS)
    local craftingBluArmor = player:getCharVar("CraftingBluArmor")
    local craftedPieces = player:getCharVar("LathuyaCraftingList_Mask")
    local totalCraftedPieces = player:countMaskBits(player:getCharVar("LathuyaCraftingList_Mask"))
    local currentTask = player:getCharVar("LathuyaCurrentTask_Mask")
    local pickupReady = vanaDay() > player:getCharVar("BluPaymentDay")
    local craftmanAwake = vanaDay() > player:getCharVar("BluRestingDay")
    local csOffset = 8 * totalCraftedPieces

    -- OMENS
    if omens == QUEST_ACCEPTED then
        if omensProgress == 3 then
            player:startEvent(714) -- Tells Master location
        elseif omensProgress == 4 then
            player:startEvent(715) -- Reminder of master location
        elseif omensProgress == 5 then
            player:startEvent(716) -- Master spoken to
        end

    -- CRAFTING OTHER 3 BLUE MAGE ARMOR PIECES
    elseif transformations >= QUEST_ACCEPTED then
        if currentTask == 0 and totalCraftedPieces ~= 3 then
            if craftmanAwake then
                if totalCraftedPieces == 2 then
                    currentTask = 7 - craftedPieces
                    player:startEvent(746, 0, 0, 0, 0, 0, 0, 0, craftingItems[currentTask][8]) -- 8th param is response
                else
                    player:startEvent(730 + csOffset, craftedPieces) -- Will prompt for choosing which armor to work on
                end
            else
                player:startEvent(737 + (csOffset - 8)) -- Asleep message, wait until 1 day passes
            end
        elseif player:countMaskBits(player:getCharVar("LathuyaCurrentTask_Mask")) == 1 then
            if craftingBluArmor == 0 then
                player:startEvent(731 + csOffset , 0, craftingItems[currentTask][5], craftingItems[currentTask][6])
            elseif craftingBluArmor == 1 then
                player:startEvent(733 + csOffset , craftingItems[currentTask][7], craftingItems[currentTask][5], craftingItems[currentTask][6])
            elseif craftingBluArmor == 2 and not pickupReady then
                player:startEvent(735 + csOffset)
            elseif craftingBluArmor == 2 and pickupReady then
                player:startEvent(736 + csOffset, craftingItems[currentTask][7])
            end
        elseif totalCraftedPieces == 3 then
            player:startEvent(753) -- Default dialog after completing questline.
        end

    elseif omens == QUEST_COMPLETED then
            player:startEvent(718) -- Default dialog
    -- DEFAULT DIALOG
    else
        player:startEvent(770)
    end
end

function onEventUpdate(player, csid, option)
    local totalCraftedPieces = player:countMaskBits(player:getCharVar("LathuyaCraftingList_Mask"))
    local csOffset = 8 * totalCraftedPieces

    if csid == 730 + csOffset then
        local currentTask = player:getCharVar("LathuyaCurrentTask_Mask")

        -- MAGUS BASUBANDS
        if option == 2 then
            player:setCharVar("LathuyaCurrentTask_Mask", 0)
            player:setMaskBit(player:getCharVar("LathuyaCurrentTask_Mask"), "LathuyaCurrentTask_Mask", 0, true)
            local currentTask = player:getCharVar("LathuyaCurrentTask_Mask")
            player:updateEvent(0, craftingItems[currentTask][1], craftingItems[currentTask][2], craftingItems[currentTask][3], craftingItems[currentTask][4])
        elseif option == 3 then
            player:updateEvent(0, craftingItems[currentTask][5], craftingItems[currentTask][6])

            -- MAGUS SHALWAR
        elseif option == 5 then
            player:setCharVar("LathuyaCurrentTask_Mask", 0)
            player:setMaskBit(player:getCharVar("LathuyaCurrentTask_Mask"), "LathuyaCurrentTask_Mask", 1, true)
            local currentTask = player:getCharVar("LathuyaCurrentTask_Mask")
            player:updateEvent(0, craftingItems[currentTask][1], craftingItems[currentTask][2], craftingItems[currentTask][3], craftingItems[currentTask][4])
        elseif option == 6 then
            player:updateEvent(0, craftingItems[currentTask][5], craftingItems[currentTask][6])

            -- MAGUS JUBBAH
        elseif option == 8 then
            player:setCharVar("LathuyaCurrentTask_Mask", 0)
            player:setMaskBit(player:getCharVar("LathuyaCurrentTask_Mask"), "LathuyaCurrentTask_Mask", 2, true)
            local currentTask = player:getCharVar("LathuyaCurrentTask_Mask")
            player:updateEvent(0, craftingItems[currentTask][1], craftingItems[currentTask][2], craftingItems[currentTask][3], craftingItems[currentTask][4])
        elseif option == 9 then
            player:updateEvent(0, craftingItems[currentTask][5], craftingItems[currentTask][6])
        end
    end
end

function onEventFinish(player, csid, option)
    local totalCraftedPieces = player:countMaskBits(player:getCharVar("LathuyaCraftingList_Mask"))
    local omensProgress = player:getCharVar("OmensProgress")
    local currentTask = player:getCharVar("LathuyaCurrentTask_Mask")
    local csOffset = 8 * totalCraftedPieces

    -- OMENS
    if csid == 714 and omensProgress == 3 then
        player:setCharVar("OmensProgress", 4)
    elseif csid == 716 and omensProgress == 5 then
        npcUtil.completeQuest(player, AHT_URHGAN, tpz.quest.id.ahtUrhgan.OMENS, {
            item = 15684,
            title = tpz.title.IMMORTAL_LION,
            var = { OmensProgress }
        })
        player:delKeyItem(tpz.ki.SEALED_IMMORTAL_ENVELOPE)

    -- TRANSFORMATIONS
    elseif csid == 732 + csOffset then
        player:setCharVar("CraftingBluArmor", 1)
        player:confirmTrade()
    elseif csid == 734 + csOffset then
        player:setCharVar("CraftingBluArmor", 2)
        npcUtil.giveKeyItem(player, tpz.ki.MAGUS_ORDER_SLIP)
        player:setCharVar("BluPaymentDay", vanaDay())
        player:confirmTrade()
    elseif csid == 736 + csOffset then
        if npcUtil.giveItem(player, craftingItems[currentTask][7]) then
            if currentTask == 1 then
                player:setMaskBit(player:getCharVar("LathuyaCraftingList_Mask"), "LathuyaCraftingList_Mask", 0, true)
            elseif currentTask == 2 then
                player:setMaskBit(player:getCharVar("LathuyaCraftingList_Mask"), "LathuyaCraftingList_Mask", 1, true)
            elseif currentTask == 4 then
                player:setMaskBit(player:getCharVar("LathuyaCraftingList_Mask"), "LathuyaCraftingList_Mask", 2, true)
            end
            player:setCharVar("BluPaymentDay", 0)
            player:setCharVar("CraftingBluArmor", 0)
            player:setCharVar("LathuyaCurrentTask_Mask", 0)
            player:setCharVar("BluRestingDay", vanaDay())
            player:delKeyItem(tpz.ki.MAGUS_ORDER_SLIP)
        end
    end
end