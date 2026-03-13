-----------------------------------
-- Area: Aht Urhgan Whitegate
-- NPC: Dhima Polevhia
-- PUP AF Sidequest: Puppetmaster Blues
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Used variables:
-- [AF]pupCrafted  -> Important variable elsewhere. Used for AF reset system, which means we cannot clean it up.
-- [PUP]orderId    -> Tracks Id of the item being crafted. Cleaned up on finish.
-- [PUP]orderStage -> Tracks where in the process we are. (0 = Haven't started. 1 = Ordered. 2 = Given items.) Cleaned up on finish.
-- [PUP]orderTime  -> Tracks when the order will be ready. Set after succesful trade. Cleaned up on finish.

local dataTable =
{   -- [Item Id] = { Bit, trade quantity }
    [xi.item.PUPPETRY_TOBE     ] = { 1, 5 },
    [xi.item.PUPPETRY_DASTANAS ] = { 2, 5 },
    [xi.item.PUPPETRY_BABOUCHES] = { 3, 6 },
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

entity.onTrade = function(player, npc, trade)
    -- Early return: No order placed.
    local orderedItemId = player:getCharVar('[PUP]orderId')
    if orderedItemId == 0 then
        return
    end

    -- Early return: No data for the order.
    local recipe = tradeTable[orderedItemId]
    if not recipe then
        return
    end

    -- Check all items involved in the recipe and track the total quantity.
    local itemCount = 0
    for i = 1, #recipe do
        local itemId       = recipe[i][1]
        local itemQuantity = recipe[i][2]
        if trade:hasItemQty(itemId, itemQuantity) then
            itemCount = itemCount + itemQuantity
        else
            return
        end
    end

    -- Check for exact item quantity.
    if itemCount == dataTable[orderedItemId][2] then
        player:startEvent(795)
    end
end

entity.onTrigger = function(player, npc)
    local piecesBitmask = player:getCharVar('[AF]pupCrafted')
    local piecesNumber  = utils.mask.countBits(piecesBitmask, 4)
    local orderId       = player:getCharVar('[PUP]orderId')
    local orderStage    = player:getCharVar('[PUP]orderStage')
    local orderTime     = player:getCharVar('[PUP]orderTime')

    -- Trade completed. Check time.
    if orderStage == 2 then
        if VanadielUniqueDay() > orderTime then
            if piecesNumber == 2 then
                player:startEvent(793) -- Order is ready. Last time.
            else
                player:startEvent(792) -- Order is ready. First and second time.
            end
        else
            player:startEvent(796) -- Order is not ready.
        end

    -- Placed order. Waiting for trade.
    elseif orderStage == 1 then
        player:startEvent(790, 0, 0, 0, dataTable[orderId][1])

    -- Has made all pieces already.
    elseif piecesNumber >= 3 then
        player:startEvent(788)

    -- Place order. (Not first time).
    elseif piecesNumber > 0 then
        player:startEvent(791, 0, piecesBitmask)

    -- Place order. (First time)
    elseif player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES) >= xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(789)

    -- Default.
    else
        player:startEvent(788)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local orderId = player:getCharVar('[PUP]orderId')

    -- "Place order" events.
    if csid == 789 or csid == 791 then
        if option == 1 then
            player:setCharVar('[PUP]orderId', xi.item.PUPPETRY_TOBE)
            player:setCharVar('[PUP]orderStage', 1)
        elseif option == 2 then
            player:setCharVar('[PUP]orderId', xi.item.PUPPETRY_DASTANAS)
            player:setCharVar('[PUP]orderStage', 1)
        elseif option == 3 then
            player:setCharVar('[PUP]orderId', xi.item.PUPPETRY_BABOUCHES)
            player:setCharVar('[PUP]orderStage', 1)
        end
    end

    -- "Complete order" events.
    if csid == 792 or csid == 793 then
        if npcUtil.giveItem(player, orderId) then
            player:incrementCharVar('[AF]pupCrafted', bit.lshift(1, dataTable[orderId][1]))
            player:setCharVar('[PUP]orderId', 0)
            player:setCharVar('[PUP]orderStage', 0)
            player:setCharVar('[PUP]orderTime', 0)
        end
    end

    -- Trade event. Triggers on succesful trade.
    if csid == 795 then
        player:tradeComplete()
        player:setCharVar('[PUP]orderStage', 2)
        player:setCharVar('[PUP]orderTime', VanadielUniqueDay())
    end
end

return entity
