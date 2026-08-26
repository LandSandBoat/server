-----------------------------------
-- Crafted Puppetry Artifact (PUP AF)
-----------------------------------
-- Dhima Polevhia : !pos 67.802 -6.000 26.315 50
-----------------------------------
-- Dhima finishes a piece overnight: it is handed over once the Vana'diel day has changed since the materials were traded.
-- No area change is needed, and the next order can be placed straight away.
-- The commission state stays in the [PUP] character variables.
-- [AF]pupCrafted is shared with the artifact reset system, so the container cannot own the naming.
-----------------------------------

local quest = HiddenQuest:new('PuppetryArtifact')

local pieceBits =
{
    [xi.item.PUPPETRY_TOBE     ] = 1,
    [xi.item.PUPPETRY_DASTANAS ] = 2,
    [xi.item.PUPPETRY_BABOUCHES] = 3,
}

local tradeTable =
{
    [xi.item.PUPPETRY_TOBE] =
    {
        [1] = { xi.item.RUBY,                          1 },
        [2] = { xi.item.SQUARE_OF_MOBLINWEAVE,         1 },
        [3] = { xi.item.SQUARE_OF_SCARLET_LINEN_CLOTH, 1 },
        [4] = { xi.item.SQUARE_OF_WAMOURA_CLOTH,       1 },
        [5] = { xi.item.IMPERIAL_GOLD_PIECE,           1 },
    },
    [xi.item.PUPPETRY_DASTANAS] =
    {
        [1] = { xi.item.PLATINUM_SHEET,          1 },
        [2] = { xi.item.SPOOL_OF_RAINBOW_THREAD, 1 },
        [3] = { xi.item.SQUARE_OF_MARID_LEATHER, 1 },
        [4] = { xi.item.SQUARE_OF_WAMOURA_CLOTH, 1 },
        [5] = { xi.item.IMPERIAL_MYTHRIL_PIECE,  1 },
    },
    [xi.item.PUPPETRY_BABOUCHES] =
    {
        [1] = { xi.item.PLATINUM_SHEET,          1 },
        [2] = { xi.item.RUBY,                    1 },
        [3] = { xi.item.SQUARE_OF_MARID_LEATHER, 1 },
        [4] = { xi.item.SQUARE_OF_WAMOURA_CLOTH, 1 },
        [5] = { xi.item.IMPERIAL_MYTHRIL_PIECE,  2 },
    },
}

local orderedPieces =
{
    [1] = xi.item.PUPPETRY_TOBE,
    [2] = xi.item.PUPPETRY_DASTANAS,
    [3] = xi.item.PUPPETRY_BABOUCHES,
}

local function onOrderPlaced(player, csid, option, npc)
    if orderedPieces[option] then
        player:setCharVar('[PUP]orderId', orderedPieces[option])
        player:setCharVar('[PUP]orderStage', 1)
    end
end

local function onOrderReceived(player, csid, option, npc)
    local orderId = player:getCharVar('[PUP]orderId')

    if npcUtil.giveItem(player, orderId) then
        player:incrementCharVar('[AF]pupCrafted', bit.lshift(1, pieceBits[orderId]))
        player:setCharVar('[PUP]orderId', 0)
        player:setCharVar('[PUP]orderStage', 0)
        player:setCharVar('[PUP]orderTime', 0)
    end
end

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES) >= xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Dhima_Polevhia'] =
            {
                onTrade = function(player, npc, trade)
                    -- Materials are only accepted while an order is waiting on them.
                    if player:getCharVar('[PUP]orderStage') ~= 1 then
                        return
                    end

                    local recipe = tradeTable[player:getCharVar('[PUP]orderId')]

                    if
                        recipe and
                        npcUtil.tradeMatches(trade, recipe)
                    then
                        return quest:progressEvent(795)
                    end
                end,

                onTrigger = function(player, npc)
                    local piecesBitmask = player:getCharVar('[AF]pupCrafted')
                    local piecesNumber  = utils.mask.countBits(piecesBitmask, 4)
                    local orderId       = player:getCharVar('[PUP]orderId')
                    local orderStage    = player:getCharVar('[PUP]orderStage')
                    local orderTime     = player:getCharVar('[PUP]orderTime')

                    -- Trade completed. Check time.
                    if orderStage == 2 then
                        if VanadielUniqueDay() > orderTime then
                            if piecesNumber == 2 then
                                return quest:progressEvent(793) -- Order is ready. Last time.
                            end

                            return quest:progressEvent(792) -- Order is ready. First and second time.
                        end

                        return quest:event(796) -- Order is not ready.

                    -- Placed order. Waiting for trade.
                    elseif orderStage == 1 then
                        return quest:event(790, 0, 0, 0, pieceBits[orderId])

                    -- Has made all pieces already.
                    elseif piecesNumber == 3 then
                        return quest:event(788):replaceDefault()

                    -- Place order. (Not first time).
                    elseif piecesNumber > 0 then
                        return quest:progressEvent(791, 0, piecesBitmask)
                    end

                    -- Place order. (First time)
                    return quest:progressEvent(789)
                end,
            },

            onEventFinish =
            {
                [789] = onOrderPlaced,
                [791] = onOrderPlaced,

                [792] = onOrderReceived,
                [793] = onOrderReceived,

                [795] = function(player, csid, option, npc)
                    player:tradeComplete()
                    player:setCharVar('[PUP]orderStage', 2)
                    player:setCharVar('[PUP]orderTime', VanadielUniqueDay())
                end,
            },
        },
    },
}

return quest
