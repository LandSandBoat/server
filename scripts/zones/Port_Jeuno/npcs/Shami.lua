-----------------------------------
-- Area: Port Jeuno
--  NPC: Shami
-- Orb Seller (BCNM)
-- !pos -53.9 0 10.8 246
-----------------------------------
local entity = {}

local shamiSealItems =
{
--  Trade Item                     Seal ID, Retrieve Option,
    [xi.item.BEASTMENS_SEAL       ] = { 0, 2 },
    [xi.item.KINDREDS_SEAL        ] = { 1, 1 },
    [xi.item.KINDREDS_CREST       ] = { 2, 3 },
    [xi.item.HIGH_KINDREDS_CREST  ] = { 3, 4 },
    [xi.item.SACRED_KINDREDS_CREST] = { 4, 5 },
}

local shamiOrbItems =
{
--  Item ID                        CS, PO, SealID, Cost,
    [xi.item.CLOUDY_ORB     ] = {  5,  1,      0,   20, },
    [xi.item.SKY_ORB        ] = {  9,  2,      0,   30, },
    [xi.item.STAR_ORB       ] = {  9,  3,      0,   40, },
    [xi.item.COMET_ORB      ] = {  9,  4,      0,   50, },
    [xi.item.MOON_ORB       ] = {  9,  5,      0,   60, },
    [xi.item.CLOTHO_ORB     ] = {  9,  6,      1,   30, },
    [xi.item.LACHESIS_ORB   ] = {  9,  7,      1,   30, },
    [xi.item.ATROPOS_ORB    ] = {  9,  8,      1,   30, },
    [xi.item.THEMIS_ORB     ] = { 11,  9,      1,   99, },
    [xi.item.PHOBOS_ORB     ] = { 11, 10,      2,   30, },
    [xi.item.DEIMOS_ORB     ] = { 11, 11,      2,   50, },
    [xi.item.ZELOS_ORB      ] = { 11, 12,      3,   30, },
    [xi.item.BIA_ORB        ] = { 11, 13,      3,   50, },
    [xi.item.MICROCOSMIC_ORB] = { 11, 14,      4,   10, },
    [xi.item.MACROCOSMIC_ORB] = { 11, 15,      4,   20, },
}

local function getSealTradeOption(trade)
    for itemID, sealData in pairs(shamiSealItems) do
        if npcUtil.tradeHasOnly(trade, itemID) then
            return sealData[1]
        end
    end

    return nil
end

local function convertSealRetrieveOption(option)
    for itemID, sealData in pairs(shamiSealItems) do
        if (option + sealData[2]) % 256 == 0 then
            local sealCount = (option + sealData[2]) / 256 - 1
            return itemID, sealData[1], sealCount
        end
    end

    return nil, nil, nil
end

-- Returns the event ID associated for displaying where the player can
-- use the orbs (BCNMs).  Event 22 is the generic cracked orb CS
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

local function getOrbDataFromOption(option)
    for itemID, orbData in pairs(shamiOrbItems) do
        if orbData[2] == option then
            return itemID, orbData[3], orbData[4]
        end
    end

    return nil
end

entity.onTrade = function(player, npc, trade)
    -- Trading Seals/Crests
    local sealOption = getSealTradeOption(trade)
    if sealOption ~= nil then
        local eventParams = { 321, 0, 0, 0, 0, 0 }
        local storedSeals = player:getSeals(sealOption)
        local itemCount = trade:getItemCount()

        eventParams[sealOption + 2] = bit.lshift(storedSeals + itemCount, 16)
        player:startEvent(unpack(eventParams))
        player:addSeals(itemCount, sealOption)
        player:confirmTrade()
        return
    end

    -- Trading Orbs
    local orbEvent = getOrbEvent(player, trade)
    if orbEvent ~= nil then
        player:startEvent(orbEvent)
    end
end

entity.onTrigger = function(player, npc)
    local beastmensSeal = player:getSeals(0)
    local kindredsSeal = player:getSeals(1)
    local kindredsCrest = player:getSeals(2)
    local highKindredsCrest = player:getSeals(3)
    local sacredKindredsCrest = player:getSeals(4)

    -- TODO: player:startEvent(322, 0, 0, 0, 0, 1, 0, 1) -- First time talking to him WITH beastmen seal in inventory
    if beastmensSeal + kindredsSeal + kindredsCrest + highKindredsCrest + sacredKindredsCrest == 0 then
        player:startEvent(23) -- Standard dialog ?
    else
        player:startEvent(322, (kindredsSeal * 65536) + beastmensSeal, (highKindredsCrest * 65536) + kindredsCrest, sacredKindredsCrest, 0, 1, 0, 0) -- Standard dialog with menu
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- Cracked orb was traded
    if csid == 22 then
        player:confirmTrade()

    -- Retrieving Seals (Option 1073741824 is escaping out of cutscene, and we do not process on this)
    elseif option >= 508 and option ~= 1073741824 then
        local itemID, sealID, retrievedSealCount = convertSealRetrieveOption(option)

        if npcUtil.giveItem(player, { { itemID, retrievedSealCount } }) then
            player:delSeals(retrievedSealCount, sealID)
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
            if npcUtil.giveItem(player, itemID) then
                player:delSeals(sealCost, sealType)
            end
        end
    end
end

return entity
