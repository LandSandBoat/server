-----------------------------------
-- Era Conquest Point Costs Module
-- Adjusts conquest point costs for various items to era-appropriate values
-- TODO: Remove printToPlayer messages and getItemName function after DAT edits
-----------------------------------
local m = Module:new('era_conquest_costs')

-- Helper function to get item name from item ID
local function getItemName(itemId)
    for itemKey, id in pairs(xi.item) do
        if id == itemId then
            -- Convert SCROLL_OF_INSTANT_RERAISE to 'Scroll of Instant Reraise'
            local name = itemKey:gsub('_', ' '):lower()
            return name:gsub("(%a)([%w_']*)", function(first, rest)
                return first:upper() .. rest
            end)
        end
    end

    return 'Unknown Item'
end

-- Define era-appropriate CP costs: [option_id] = { cost, item_id, available }
-- Set available = false to remove an item from availability (default is true)
local eraCosts =
{
    -- Cost adjustments
    [32928] = { 500, xi.item.SCROLL_OF_INSTANT_RERAISE },        -- 7 -> 500 CP
    [32929] = { 750, xi.item.SCROLL_OF_INSTANT_WARP },           -- 10 -> 750 CP

    -- Remove items (not appropriate for 75-cap era)
    [32935] = { 0, xi.item.EMPEROR_BAND, false },                -- Remove Emperor Band
    [32936] = { 0, xi.item.WARP_RING, false },                   -- Remove Warp Ring
    [32937] = { 0, xi.item.CIPHER_OF_TENZENS_ALTER_EGO, false }, -- Remove Trust Ciphers
    [32938] = { 0, xi.item.CIPHER_OF_RAHALS_ALTER_EGO, false },
    [32939] = { 0, xi.item.CIPHER_OF_KUKKIS_ALTER_EGO, false },
    [32942] = { 0, xi.item.CIPHER_OF_MAKKIS_ALTER_EGO, false },
}

m:addOverride('xi.conquest.overseerOnEventUpdate', function(player, csid, option, guardNation)
    local eraCost = eraCosts[option]
    if not eraCost then
        return super(player, csid, option, guardNation)
    end

    local cost, itemId, available = eraCost[1], eraCost[2], eraCost[3]
    available = available ~= false
    local itemName = getItemName(itemId)

    -- If item is not available, make it unavailable
    if not available then
        player:updateEvent(0, 1, itemId) -- u1=0 (can't equip), u2=1 (can't afford)
        player:printToPlayer(string.format('NOTICE: %s is not available on this server.', itemName), xi.msg.channel.SYSTEM_3)
        return
    end

    -- Notify player of adjusted cost
    player:printToPlayer(string.format('NOTICE: %s now costs %d conquest points.', itemName, cost), xi.msg.channel.SYSTEM_3)

    local u1 = 2                                  -- can equip
    local u2 = (cost > player:getCP()) and 1 or 0 -- can afford

    -- Handle voucher for exp rings
    if
        option >= 32933 and
        option <= 32935 and
        player:hasKeyItem(xi.keyItem.CONQUEST_PROMOTION_VOUCHER)
    then
        u2 = 0
    end

    if u2 == 0 then
        player:setLocalVar('boughtItemCP', itemId)
        player:setLocalVar('eraCost_' .. option, cost)
    end

    player:updateEvent(u1, u2, itemId)
end)

-- Override event finish to charge correct costs
m:addOverride('xi.conquest.overseerOnEventFinish', function(player, csid, option, guardNation, guardType, guardRegion)
    local eraCost = eraCosts[option]
    if not eraCost or option < 32768 or option > 32944 then
        return super(player, csid, option, guardNation, guardType, guardRegion)
    end

    local cost, itemId, available = eraCost[1], eraCost[2], eraCost[3]
    available = available ~= false

    local storedCost = player:getLocalVar('eraCost_' .. option)

    if storedCost == cost and player:getCP() >= cost then
        player:setLocalVar('eraCost_' .. option, 0)
        if npcUtil.giveItem(player, itemId) then
            player:delCP(cost)
        end
    else
        player:messageSpecial(zones[player:getZoneID()].text.CONQUEST + 62, 0, 0, itemId)
    end
end)
