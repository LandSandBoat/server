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
    [1] = -- magus bazubands
    {
        materials = {754, 828, 879, 4158},
        currency = 2186,
        currencyAmt = 2,
        result = 14928
    },
    [2] = -- magus shalwar
    {
        materials = {761, 828, 2175, 2340},
        currency = 2186,
        currencyAmt = 2,
        result = 15600
    },
    [3] = -- magus jubbah
    {
        materials = {828, 2229, 2288, 2340},
        currency = 2186,
        currencyAmt = 4,
        result = 14521
    }  
}

function onTrade(player, npc, trade)
    local remainingBLUAF = player:getCharVar("[BLUAF]Remaining") -- Bitmask of AF the player has NOT crafted
    if remainingBLUAF >= 1 then
        local craftingStage = player:getCharVar("[BLUAF]CraftingStage")
        local totalCraftedPieces = 3 - player:countMaskBits(remainingBLUAF)
        local AFoffset = 8 * totalCraftedPieces

        local item = craftingItems[player:getCharVar("[BLUAF]Current")]
        if item then
            if craftingStage == 0  and npcUtil.tradeHasExactly(trade, item.materials) then
                player:startEvent(732 + AFoffset, item.result, item.currency, item.currencyAmt)
            elseif craftingStage == 1 and npcUtil.tradeHasExactly(trade, {{item.currency, item.currencyAmt}}) then
                player:startEvent(734 + AFoffset, 0, item.currency, item.currencyAmt)
           end
       end
   end
end

function onTrigger(player, npc)
    local omensProgress = player:getCharVar("OmensProgress")
    local omens = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.OMENS)
    local transformations = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.TRANSFORMATIONS)

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
        local remainingBLUAF = player:getCharVar("[BLUAF]Remaining") -- Bitmask of AF the player has NOT crafted
        local totalCraftedPieces = 3 - player:countMaskBits(remainingBLUAF)
        local currentTask = player:getCharVar("[BLUAF]Current")
        local craftingStage = player:getCharVar("[BLUAF]CraftingStage")
        local AFoffset = 8 * totalCraftedPieces

        if currentTask == 0 and totalCraftedPieces ~= 3 then
            if vanaDay() > player:getCharVar("[BLUAF]RestingDay") then
                if totalCraftedPieces == 2 then
                    currentTask = math.floor(remainingBLUAF / 2) + 1
                    player:startEvent(746, 0, 0, 0, 0, 0, 0, 0, currentTask)
                else
                    -- Will prompt for choosing which armor to work on
                    player:startEvent(730 + AFoffset, 7 - player:getCharVar("[BLUAF]Remaining"))
                end
            else
                player:startEvent(737 + (AFoffset - 8)) -- Asleep message, wait until 1 day passes
            end
        elseif currentTask > 0 then
            local pickupReady = vanaDay() > player:getCharVar("[BLUAF]PaymentDay")
            local item = craftingItems[currentTask]
            if craftingStage == 0 then
                player:startEvent(731 + AFoffset, 0, item.currency, item.currencyAmt)
            elseif craftingStage == 1 then
                player:startEvent(733 + AFoffset, item.result, item.currency, item.currencyAmt)
            elseif craftingStage == 2 and not pickupReady then
                player:startEvent(735 + AFoffset)
            elseif craftingStage == 2 and pickupReady then
                player:startEvent(736 + AFoffset, item.result)
            end
        elseif totalCraftedPieces == 3 then
            player:startEvent(753) -- Dialogue after crafting all BLU AF
        end

    elseif omens == QUEST_COMPLETED then
        player:startEvent(718)
    else
        player:startEvent(770) -- Default dialogue
    end
end

function onEventUpdate(player, csid, option)
    local remainingBLUAF = player:getCharVar("[BLUAF]Remaining") -- Bitmask of AF the player has NOT crafted
    local totalCraftedPieces = 3 - player:countMaskBits(remainingBLUAF)
    local AFoffset = 8 * totalCraftedPieces

    if csid == 730 + AFoffset then
        if option >= 2 and option <= 9 then
            local currentTask = player:getCharVar("[BLUAF]Current")
            local updateType = option % 3
            if updateType == 2 then
                -- Choosing a piece
                local piece = math.floor(option / 4) + 1
                local pieceMask = math.pow(2, (piece - 1))
                -- Make sure the player isn't trying to cheat somehow
                if bit.band(pieceMask, player:getCharVar("[BLUAF]Remaining")) > 0 then
                    player:setCharVar("[BLUAF]Current", piece)
                    local item = craftingItems[piece]
                    player:updateEvent(0, unpack(item.materials))
                end
            else
                -- Needs payment
                local item = craftingItems[currentTask]
                player:updateEvent(0, item.currency, item.currencyAmt)
            end
        end
    end
end

function onEventFinish(player, csid, option)
    local omensProgress = player:getCharVar("OmensProgress")

    local remainingBLUAF = player:getCharVar("[BLUAF]Remaining") -- Bitmask of AF the player has NOT crafted
    local totalCraftedPieces = 3 - player:countMaskBits(remainingBLUAF)
    local currentTask = player:getCharVar("[BLUAF]Current")
    local AFoffset = 8 * totalCraftedPieces

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

    -- BLU AF CRAFTING
    elseif csid == 732 + AFoffset then
        player:setCharVar("[BLUAF]CraftingStage", 1)
        player:confirmTrade()
    elseif csid == 734 + AFoffset then
        player:confirmTrade()
        player:setCharVar("[BLUAF]CraftingStage", 2)
        player:setCharVar("[BLUAF]PaymentDay", vanaDay())
        npcUtil.giveKeyItem(player, tpz.ki.MAGUS_ORDER_SLIP)
    elseif csid == 736 + AFoffset then
        if npcUtil.giveItem(player, craftingItems[currentTask].result) then
            remainingBLUAF = remainingBLUAF - math.pow(2, (currentTask - 1))
            player:setCharVar("[BLUAF]Remaining", remainingBLUAF)
            player:setCharVar("[BLUAF]PaymentDay", 0)
            player:setCharVar("[BLUAF]CraftingStage", 0)
            player:setCharVar("[BLUAF]Current", 0)

            if player:getCharVar("[BLUAF]Remaining") == 0 then
                -- Player is finished with Lathuya
                player:setCharVar("[BLUAF]RestingDay", 0)
            else
                player:setCharVar("[BLUAF]RestingDay", vanaDay())  
            end

            player:delKeyItem(tpz.ki.MAGUS_ORDER_SLIP)
        end
    end
end