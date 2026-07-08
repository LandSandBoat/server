-----------------------------------
-- Area: Nashmau
--  NPC: Awaheen
-----------------------------------
---@type TNpcEntity
local entity = {}

local currencyExchangeData =
{
    [xi.item.IMPERIAL_GOLD_PIECE   ] = 5,
    [xi.item.IMPERIAL_MYTHRIL_PIECE] = 2,
    [xi.item.IMPERIAL_SILVER_PIECE ] = 5,
}

entity.onTrade = function(player, npc, trade)
    for currencyType, exchangeMultiplier in pairs(currencyExchangeData) do
        if
            npcUtil.tradeHasOnly(trade, currencyType) and
            npcUtil.giveItem(player, { { currencyType - 1, trade:getItemCount() * exchangeMultiplier } })
        then
            player:tradeComplete()
            break
        end
    end
end

return entity
