-----------------------------------
-- Crafted Magus Artifact (BLU AF)
-----------------------------------
-- Lathuya : !pos -95.081 -6.000 31.638 50
-----------------------------------
-- A commissioned piece is finished overnight: it is handed over once the Vana'diel day has changed since the fee was paid, and only after an area change.
-- Ordering the next piece needs a second day change and another area change.
-- The commission state stays in the [BLUAF] character variables.
-- Transformations seeds [BLUAF]Remaining, so the container cannot own the naming.
-----------------------------------

local quest = HiddenQuest:new('MagusArtifact')

local craftingItems =
{
    [1] = -- magus bazubands
    {
        materials =
        {
            { xi.item.PLATINUM_SHEET,            1 },
            { xi.item.SQUARE_OF_VELVET_CLOTH,    1 },
            { xi.item.SQUARE_OF_KARAKUL_LEATHER, 1 },
            { xi.item.FLASK_OF_VENOM_POTION,     1 },
        },
        currency = xi.item.IMPERIAL_MYTHRIL_PIECE,
        currencyAmt = 2,
        result = xi.item.MAGUS_BAZUBANDS,
    },

    [2] = -- magus shalwar
    {
        materials =
        {
            { xi.item.GOLD_CHAIN,                    1 },
            { xi.item.SQUARE_OF_VELVET_CLOTH,        1 },
            { xi.item.CHUNK_OF_FLAN_MEAT,            1 },
            { xi.item.SQUARE_OF_IMPERIAL_SILK_CLOTH, 1 },
        },
        currency = xi.item.IMPERIAL_MYTHRIL_PIECE,
        currencyAmt = 2,
        result = xi.item.MAGUS_SHALWAR,
    },

    [3] = -- magus jubbah
    {
        materials =
        {
            { xi.item.SQUARE_OF_VELVET_CLOTH,        1 },
            { xi.item.VIAL_OF_CHIMERA_BLOOD,         1 },
            { xi.item.SQUARE_OF_KARAKUL_CLOTH,       1 },
            { xi.item.SQUARE_OF_IMPERIAL_SILK_CLOTH, 1 },
        },
        currency = xi.item.IMPERIAL_MYTHRIL_PIECE,
        currencyAmt = 4,
        result = xi.item.MAGUS_JUBBAH,
    },
}

local function onPieceSelected(player, csid, option, npc)
    if option < 2 or option > 9 then
        return
    end

    local remainingBLUAF = player:getCharVar('[BLUAF]Remaining')

    -- Choosing a piece.
    if option % 3 == 2 then
        local piece = math.floor(option / 4) + 1

        -- Make sure the player isn't trying to cheat somehow
        if utils.mask.getBit(remainingBLUAF, piece - 1) then
            player:setCharVar('[BLUAF]Current', piece)

            local materials = {}
            for _, material in ipairs(craftingItems[piece].materials) do
                materials[#materials + 1] = material[1]
            end

            player:updateEvent(0, unpack(materials))
        end

        return
    end

    local item = craftingItems[player:getCharVar('[BLUAF]Current')]

    if item then
        player:updateEvent(0, item.currency, item.currencyAmt)
    end
end

local function onMaterialsTraded(player, csid, option, npc)
    player:setCharVar('[BLUAF]CraftingStage', 1)
    player:tradeComplete()
end

local function onFeeTraded(player, csid, option, npc)
    player:tradeComplete()
    player:setCharVar('[BLUAF]CraftingStage', 2)
    player:setCharVar('[BLUAF]PaymentDay', VanadielUniqueDay())
    quest:setMustZone(player)
    npcUtil.giveKeyItem(player, xi.ki.MAGUS_ORDER_SLIP)
end

local function onPieceReceived(player, csid, option, npc)
    local remainingBLUAF = player:getCharVar('[BLUAF]Remaining')
    local currentTask    = player:getCharVar('[BLUAF]Current')

    if
        currentTask == 0 or
        not npcUtil.giveItem(player, craftingItems[currentTask].result)
    then
        return
    end

    player:setCharVar('[BLUAF]Remaining', utils.mask.setBit(remainingBLUAF, currentTask - 1, false))
    player:setCharVar('[BLUAF]PaymentDay', 0)
    player:setCharVar('[BLUAF]CraftingStage', 0)
    player:setCharVar('[BLUAF]Current', 0)

    -- Player is finished with Lathuya
    if player:getCharVar('[BLUAF]Remaining') == 0 then
        player:setCharVar('[BLUAF]RestingDay', 0)
    else
        player:setCharVar('[BLUAF]RestingDay', VanadielUniqueDay())
        quest:setMustZone(player)
    end

    player:delKeyItem(xi.ki.MAGUS_ORDER_SLIP)
end

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.TRANSFORMATIONS) >= xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Lathuya'] =
            {
                onTrade = function(player, npc, trade)
                    local remainingBLUAF = player:getCharVar('[BLUAF]Remaining')
                    local item           = craftingItems[player:getCharVar('[BLUAF]Current')]

                    if
                        remainingBLUAF == 0 or
                        not item
                    then
                        return
                    end

                    local craftingStage  = player:getCharVar('[BLUAF]CraftingStage')
                    local artifactOffset = 8 * (3 - utils.mask.countBits(remainingBLUAF, 3))

                    if
                        craftingStage == 0 and
                        npcUtil.tradeMatches(trade, item.materials)
                    then
                        return quest:progressEvent(732 + artifactOffset, item.result, item.currency, item.currencyAmt)
                    elseif
                        craftingStage == 1 and
                        npcUtil.tradeMatches(trade, { { item.currency, item.currencyAmt } })
                    then
                        return quest:progressEvent(734 + artifactOffset, 0, item.currency, item.currencyAmt)
                    end
                end,

                onTrigger = function(player, npc)
                    local remainingBLUAF     = player:getCharVar('[BLUAF]Remaining')
                    local totalCraftedPieces = 3 - utils.mask.countBits(remainingBLUAF, 3)
                    local currentTask        = player:getCharVar('[BLUAF]Current')
                    local craftingStage      = player:getCharVar('[BLUAF]CraftingStage')
                    local artifactOffset     = 8 * totalCraftedPieces

                    -- No order placed, and there is still a piece left to make.
                    if currentTask == 0 and totalCraftedPieces ~= 3 then
                        -- The next order is taken a day later, after leaving the area.
                        if
                            VanadielUniqueDay() > player:getCharVar('[BLUAF]RestingDay') and
                            not quest:getMustZone(player)
                        then
                            -- Only one piece is left, so there is nothing to choose.
                            if totalCraftedPieces == 2 then
                                return quest:progressEvent(746, { [7] = math.floor(remainingBLUAF / 2) + 1 })
                            end

                            -- Will prompt for choosing which armor to work on
                            return quest:progressEvent(730 + artifactOffset, 7 - remainingBLUAF)
                        end

                        return quest:event(737 + (artifactOffset - 8)) -- Asleep message, wait until 1 day passes

                    -- An order is in progress.
                    elseif currentTask > 0 then
                        local item = craftingItems[currentTask]

                        if craftingStage == 0 then
                            return quest:event(731 + artifactOffset, 0, item.currency, item.currencyAmt)
                        elseif craftingStage == 1 then
                            return quest:event(733 + artifactOffset, item.result, item.currency, item.currencyAmt)
                        end

                        -- The piece is handed over a day later, after leaving the area.
                        if
                            VanadielUniqueDay() > player:getCharVar('[BLUAF]PaymentDay') and
                            not quest:getMustZone(player)
                        then
                            return quest:progressEvent(736 + artifactOffset, item.result)
                        end

                        return quest:event(735 + artifactOffset)
                    end

                    return quest:event(753):replaceDefault() -- Dialogue after crafting all BLU AF
                end,
            },

            onEventUpdate =
            {
                [730] = onPieceSelected,
                [738] = onPieceSelected,
                [746] = onPieceSelected,
            },

            onEventFinish =
            {
                [732] = onMaterialsTraded,
                [740] = onMaterialsTraded,
                [748] = onMaterialsTraded,

                [734] = onFeeTraded,
                [742] = onFeeTraded,
                [750] = onFeeTraded,

                [736] = onPieceReceived,
                [744] = onPieceReceived,
                [752] = onPieceReceived,
            },
        },
    },
}

return quest
