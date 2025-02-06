-----------------------------------
-- Seals and Crests trade (Shami/Shemo)
-----------------------------------
xi = xi or {}
xi.seals = xi.seals or {}

---@class sealItems
---@field [xi.item] { [integer]: integer, [integer]: integer }
xi.seals.sealItems =
{
    -- Trade Item ID              Seal ID, Retrieve Option
    [xi.item.BEASTMENS_SEAL       ] = { 0, 2 },
    [xi.item.KINDREDS_SEAL        ] = { 1, 1 },
    [xi.item.KINDREDS_CREST       ] = { 2, 3 },
    [xi.item.HIGH_KINDREDS_CREST  ] = { 3, 4 },
    [xi.item.SACRED_KINDREDS_CREST] = { 4, 5 },
}

---@nodiscard
---@param trade CTradeContainer
---@return table
local function getSealTradeOption(trade)
    local sealsInTrade = {}
    for itemID, sealData in pairs(xi.seals.sealItems) do
        if npcUtil.tradeHas(trade, itemID) then
            table.insert(sealsInTrade, { sealData[1], trade:getItemQty(itemID) })
        end
    end

    return sealsInTrade
end

-- Trading Seals/Crests
function xi.seals.onTrade(player, npc, trade, eventParams)
    local sealOptions = getSealTradeOption(trade)

    if next(sealOptions) then
        local confirmedSeals = {}
        for _, sealOption in ipairs(sealOptions) do
            local storedSeals = player:getSeals(sealOption[1])
            local itemCount   = sealOption[2]
            eventParams[sealOption[1] + 2] = bit.lshift(storedSeals + itemCount, 16)
            table.insert(confirmedSeals, { sealOption[1], itemCount })
        end

        player:startEvent(unpack(eventParams))
        for _, sealData in ipairs(confirmedSeals) do
            local sealId = sealData[1]
            local sealCount = sealData[2]
            player:addSeals(sealCount, sealId)
        end

        player:confirmTrade()

        return true
    end

    return false
end
