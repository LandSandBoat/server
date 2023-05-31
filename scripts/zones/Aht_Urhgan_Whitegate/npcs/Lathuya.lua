-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Lathuya
-- Involved in quests: Omens
-- !pos -95.081 -6.000 31.638 50
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local craftingItems =
{
    [1] = -- magus bazubands
    {
        materials = { 754, 828, 879, 4158 },
        currency = 2186,
        currencyAmt = 2,
        result = 14928
    },

    [2] = -- magus shalwar
    {
        materials = { 761, 828, 2175, 2340 },
        currency = 2186,
        currencyAmt = 2,
        result = 15600
    },

    [3] = -- magus jubbah
    {
        materials = { 828, 2229, 2288, 2340 },
        currency = 2186,
        currencyAmt = 4,
        result = 14521
    }
}

entity.onTrade = function(player, npc, trade)
    local remainingBLUAF = player:getCharVar("[BLUAF]Remaining") -- Bitmask of AF the player has NOT crafted
    if remainingBLUAF >= 1 then
        local craftingStage = player:getCharVar("[BLUAF]CraftingStage")
        local totalCraftedPieces = 3 - utils.mask.countBits(remainingBLUAF, 3)
        local artifactOffset = 8 * totalCraftedPieces

        local item = craftingItems[player:getCharVar("[BLUAF]Current")]
        if item then
            if
                craftingStage == 0 and
                npcUtil.tradeHasExactly(trade, item.materials)
            then
                player:startEvent(732 + artifactOffset, item.result, item.currency, item.currencyAmt)
            elseif
                craftingStage == 1 and
                npcUtil.tradeHasExactly(trade, { { item.currency, item.currencyAmt } })
            then
                player:startEvent(734 + artifactOffset, 0, item.currency, item.currencyAmt)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local transformations = player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.TRANSFORMATIONS)

    -- CRAFTING OTHER 3 BLUE MAGE ARMOR PIECES
    if transformations >= QUEST_ACCEPTED then
        local remainingBLUAF = player:getCharVar("[BLUAF]Remaining") -- Bitmask of AF the player has NOT crafted
        local totalCraftedPieces = 3 - utils.mask.countBits(remainingBLUAF, 3)
        local currentTask = player:getCharVar("[BLUAF]Current")
        local craftingStage = player:getCharVar("[BLUAF]CraftingStage")
        local artifactOffset = 8 * totalCraftedPieces

        if currentTask == 0 and totalCraftedPieces ~= 3 then
            if VanadielUniqueDay() > player:getCharVar("[BLUAF]RestingDay") then
                if totalCraftedPieces == 2 then
                    currentTask = math.floor(remainingBLUAF / 2) + 1
                    player:startEvent(746, 0, 0, 0, 0, 0, 0, 0, currentTask)
                else
                    -- Will prompt for choosing which armor to work on
                    player:startEvent(730 + artifactOffset, 7 - remainingBLUAF)
                end
            else
                player:startEvent(737 + (artifactOffset - 8)) -- Asleep message, wait until 1 day passes
            end
        elseif currentTask > 0 then
            local pickupReady = VanadielUniqueDay() > player:getCharVar("[BLUAF]PaymentDay")
            local item = craftingItems[currentTask]
            if craftingStage == 0 then
                player:startEvent(731 + artifactOffset, 0, item.currency, item.currencyAmt)
            elseif craftingStage == 1 then
                player:startEvent(733 + artifactOffset, item.result, item.currency, item.currencyAmt)
            elseif craftingStage == 2 and not pickupReady then
                player:startEvent(735 + artifactOffset)
            elseif craftingStage == 2 and pickupReady then
                player:startEvent(736 + artifactOffset, item.result)
            end
        elseif totalCraftedPieces == 3 then
            player:startEvent(753) -- Dialogue after crafting all BLU AF
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
    local remainingBLUAF = player:getCharVar("[BLUAF]Remaining") -- Bitmask of AF the player has NOT crafted
    local totalCraftedPieces = 3 - utils.mask.countBits(remainingBLUAF, 3)
    local artifactOffset = 8 * totalCraftedPieces

    if csid == 730 + artifactOffset then
        if option >= 2 and option <= 9 then
            local currentTask = player:getCharVar("[BLUAF]Current")
            local updateType = option % 3
            if updateType == 2 then
                -- Choosing a piece
                local piece = math.floor(option / 4) + 1
                -- Make sure the player isn't trying to cheat somehow
                if utils.mask.getBit(remainingBLUAF, piece - 1) then
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

entity.onEventFinish = function(player, csid, option)
    local remainingBLUAF = player:getCharVar("[BLUAF]Remaining") -- Bitmask of AF the player has NOT crafted
    local totalCraftedPieces = 3 - utils.mask.countBits(remainingBLUAF, 3)
    local currentTask = player:getCharVar("[BLUAF]Current")
    local artifactOffset = 8 * totalCraftedPieces

    -- BLU AF CRAFTING
    if csid == 732 + artifactOffset then
        player:setCharVar("[BLUAF]CraftingStage", 1)
        player:confirmTrade()
    elseif csid == 734 + artifactOffset then
        player:confirmTrade()
        player:setCharVar("[BLUAF]CraftingStage", 2)
        player:setCharVar("[BLUAF]PaymentDay", VanadielUniqueDay())
        npcUtil.giveKeyItem(player, xi.ki.MAGUS_ORDER_SLIP)
    elseif csid == 736 + artifactOffset and currentTask > 0 then
        if npcUtil.giveItem(player, craftingItems[currentTask].result) then
            player:setCharVar("[BLUAF]Remaining", utils.mask.setBit(remainingBLUAF, currentTask - 1, false))
            player:setCharVar("[BLUAF]PaymentDay", 0)
            player:setCharVar("[BLUAF]CraftingStage", 0)
            player:setCharVar("[BLUAF]Current", 0)

            if player:getCharVar("[BLUAF]Remaining") == 0 then
                -- Player is finished with Lathuya
                player:setCharVar("[BLUAF]RestingDay", 0)
            else
                player:setCharVar("[BLUAF]RestingDay", VanadielUniqueDay())
            end

            player:delKeyItem(xi.ki.MAGUS_ORDER_SLIP)
        end
    end
end

return entity
