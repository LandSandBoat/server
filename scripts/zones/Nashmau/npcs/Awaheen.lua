-----------------------------------
-- Area: Nashmau
--  NPC: Awaheen
-----------------------------------
local ID = zones[xi.zone.NASHMAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

local currencyExchangeData =
{
    [xi.item.IMPERIAL_GOLD_PIECE   ] = { item = xi.item.IMPERIAL_MYTHRIL_PIECE, multiplier = 5 },
    [xi.item.IMPERIAL_MYTHRIL_PIECE] = { item = xi.item.IMPERIAL_SILVER_PIECE,  multiplier = 2 },
    [xi.item.IMPERIAL_SILVER_PIECE ] = { item = xi.item.IMPERIAL_BRONZE_PIECE,  multiplier = 5 },
}

entity.onTrade = function(player, npc, trade)
    local currencyType = trade:getItemId(0)
    local exchange     = currencyExchangeData[currencyType]
    local quantity     = trade:getItemCount()

    if
        not exchange or
        not npcUtil.tradeMatches(trade, { { currencyType, quantity } })
    then
        return
    end

    local rewardQuantity = quantity * exchange.multiplier
    if player:getFreeSlotsCount() < math.ceil(rewardQuantity / 99) then
        player:showText(npc, bit.bor(ID.text.ITEM_CANNOT_BE_OBTAINEDX, 0x8000), exchange.item, rewardQuantity, currencyType, quantity, false, false, 6)
        return
    end

    if not npcUtil.giveItem(player, { { exchange.item, rewardQuantity } }, { silent = true }) then
        player:showText(npc, bit.bor(ID.text.ITEM_CANNOT_BE_OBTAINEDX, 0x8000), exchange.item, rewardQuantity, currencyType, quantity, false, false, 6)
        return
    end

    player:tradeComplete()
    player:showText(npc, bit.bor(ID.text.ITEM_OBTAINEDX, 0x8000), exchange.item, rewardQuantity, currencyType, quantity, false, false, 6)
end

return entity
