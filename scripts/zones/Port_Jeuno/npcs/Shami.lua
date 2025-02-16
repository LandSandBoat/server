-----------------------------------
-- Area: Port Jeuno
--  NPC: Shami
-- Orb Seller (BCNM)
-- !pos -53.9 0 10.8 246
-----------------------------------
---@type TNpcEntity
local entity = {}

---@class shamiOrbItems
---@field [xi.item] { [integer]: integer, [integer]: integer, [integer]: integer, [integer]: integer } }
local shamiOrbItems =
{
    -- Item ID                    CS, PO, SealID, Cost
    [xi.item.CLOUDY_ORB     ] = {  5,  1,      0,   20 },
    [xi.item.SKY_ORB        ] = {  9,  2,      0,   30 },
    [xi.item.STAR_ORB       ] = {  9,  3,      0,   40 },
    [xi.item.COMET_ORB      ] = {  9,  4,      0,   50 },
    [xi.item.MOON_ORB       ] = {  9,  5,      0,   60 },
    [xi.item.CLOTHO_ORB     ] = {  9,  6,      1,   30 },
    [xi.item.LACHESIS_ORB   ] = {  9,  7,      1,   30 },
    [xi.item.ATROPOS_ORB    ] = {  9,  8,      1,   30 },
    [xi.item.THEMIS_ORB     ] = { 11,  9,      1,   99 },
    [xi.item.PHOBOS_ORB     ] = { 11, 10,      2,   30 },
    [xi.item.DEIMOS_ORB     ] = { 11, 11,      2,   50 },
    [xi.item.ZELOS_ORB      ] = { 11, 12,      3,   30 },
    [xi.item.BIA_ORB        ] = { 11, 13,      3,   50 },
    [xi.item.MICROCOSMIC_ORB] = { 11, 14,      4,   10 },
    [xi.item.MACROCOSMIC_ORB] = { 11, 15,      4,   20 },
}

---@nodiscard
---@param option integer
---@return xi.item?, integer?, integer?
local function convertSealRetrieveOption(option)
    for itemID, sealData in pairs(xi.seals.sealItems) do
        if (option + sealData[2]) % 256 == 0 then
            local sealCount = (option + sealData[2]) / 256 - 1

            return itemID, sealData[1], sealCount
        end
    end

    return nil, nil, nil
end

-- Returns the event ID associated for displaying where the player can
-- use the orbs (BCNMs).  Event 22 is the generic cracked orb CS
---@nodiscard
---@param player CBaseEntity
---@param trade CTradeContainer
---@return integer?
local function getOrbEvent(player, trade)
    for itemID, orbData in pairs(shamiOrbItems) do
        if npcUtil.tradeHasExactly(trade, itemID) then
            if player:getWornUses(itemID) > 0 then
                return 22
            else
                return orbData[1]
            end
        end
    end

    return nil
end

---@nodiscard
---@param option integer
---@return xi.item?, integer?, integer?
local function getOrbDataFromOption(option)
    for itemID, orbData in pairs(shamiOrbItems) do
        if orbData[2] == option then
            return itemID, orbData[3], orbData[4]
        end
    end

    return nil, nil, nil
end

entity.onTrade = function(player, npc, trade)
    local eventParams = { 321, 0, 0, 0, 0, 0 }

    if xi.seals.onTrade(player, npc, trade, eventParams) then
        return
    end

    -- Trading Orbs
    local orbEvent = getOrbEvent(player, trade)
    if orbEvent ~= nil then
        player:startEvent(orbEvent)
    end
end

entity.onTrigger = function(player, npc)
    local beastmensSeal       = player:getSeals(0)
    local kindredsSeal        = player:getSeals(1)
    local kindredsCrest       = player:getSeals(2)
    local highKindredsCrest   = player:getSeals(3)
    local sacredKindredsCrest = player:getSeals(4)

    -- TODO: player:startEvent(322, 0, 0, 0, 0, 1, 0, 1) -- First time talking to him WITH beastmen seal in inventory
    if beastmensSeal + kindredsSeal + kindredsCrest + highKindredsCrest + sacredKindredsCrest == 0 then
        player:startEvent(23) -- Standard dialog ?
    else
        local purchasedOrbs = player:getCharVar('ShamiPurchasedOrbs') -- Skips the first longer dialog if the player has already purchased orbs
        player:startEvent(322, (kindredsSeal * 65536) + beastmensSeal, (highKindredsCrest * 65536) + kindredsCrest, sacredKindredsCrest, 0, 1, 0, 0, math.min(purchasedOrbs, 1)) -- Standard dialog with menu
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- Cracked orb was traded
    if csid == 22 then
        player:confirmTrade()

    -- Retrieving Seals
    elseif
        option >= 508 and
        option ~= utils.EVENT_CANCELLED_OPTION
    then
        local itemID, sealID, retrievedSealCount = convertSealRetrieveOption(option)

        if
            itemID and
            sealID and
            retrievedSealCount
        then
            local availableSeals = player:getSeals(sealID)

            if
                availableSeals >= retrievedSealCount and
                npcUtil.giveItem(player, { { itemID, retrievedSealCount } })
            then
                player:delSeals(retrievedSealCount, sealID)
            end
        end

    -- Purchasing a BCNM Orb
    -- NOTE: While Lua does short-circuit in conditionals, separating the seal check and giveItem calls
    -- to ensure that if this ever changes, it won't cause a potential exploit.
    elseif csid == 322 then
        local itemID, sealType, sealCost = getOrbDataFromOption(option)

        if
            sealType ~= nil and
            player:getSeals(sealType) >= sealCost
        then
            if
                itemID and
                sealCost and
                npcUtil.giveItem(player, itemID)
            then
                player:delSeals(sealCost, sealType)
                player:incrementCharVar('ShamiPurchasedOrbs', 1)
            end
        end
    end
end

return entity
