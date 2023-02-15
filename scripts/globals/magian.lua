-----------------------------------
-- Magian Trial Global
-----------------------------------
require('scripts/globals/common')
require('scripts/globals/items')
require('scripts/globals/magian_data')
require('scripts/globals/status')
-----------------------------------
local ruludeID = require('scripts/zones/RuLude_Gardens/IDs')
-----------------------------------
xi = xi or {}
xi.magian = xi.magian or {}
xi.magian.playerCache = xi.magian.playerCache or {}

local magianMoogleInfo =
{
    ['Magian_Moogle_Blue']   = {   nil, 10141, 10142, 10143, 10144, 10148, xi.itemType.ARMOR  },
    ['Magian_Moogle_Orange'] = { 10121, 10122, 10123, 10124, 10125, 10129, xi.itemType.WEAPON },
}

-- Returns a table of data containing the player's currently active trials, and caches this data
-- keyed by player ID into xi.magian.playerCache
local function getPlayerTrialData(player)
    local playerId  = player:getID()
    local trialData = xi.magian.playerCache[playerId]

    if trialData then
        return trialData
    end

    trialData        = {}
    local slotLookup = {}

    for trialSlot = 1, 10 do
        local packedTrial    = player:getCharVar("[trial]" .. trialSlot)
        local trialId        = bit.rshift(packedTrial, 16)
        local trialProgress  = bit.band(packedTrial, 0xFFFF)
        local objectiveTotal = xi.magian.trials[trialId] and xi.magian.trials[trialId].numRequired or 0

        trialData[trialSlot] =
        {
            trialId        = trialId,
            progress       = trialProgress,
            objectiveTotal = objectiveTotal,
        }

        if trialId > 0 then
            slotLookup[trialId] = trialSlot
        end
    end

    xi.magian.playerCache[playerId] =
    {
        trialData  = trialData,
        slotLookup = slotLookup,
    }

    return xi.magian.playerCache[playerId]
end

local function getTrialProgress(player, trialId)
    local playerTrials = getPlayerTrialData(player)

    if playerTrials.slotLookup[trialId] then
        return playerTrials.trialData.progress
    end

    return 0
end

-- Returns the slot in which a specific trial for a player is stored, or
-- returns nil if not active.

-- NOTE: This function relies on cached player data, though all functions that
-- use this will have cached data.
local function getTrialSlot(player, trialId)
    return xi.magian.playerCache[player:getID()].slotLookup[trialId]
end

-- Updates Player Trial Data in Lua cache and database
local function updatePlayerTrial(player, trialSlot, trialId, progress)
    local playerTrialData = getPlayerTrialData(player)

    if
        trialId == playerTrialData.trialData[trialSlot].trialId and
        progress == playerTrialData.trialData[trialSlot].progress
    then
        return
    end

    -- If clearing out a trial, ensure that slotLookup data is also removed
    if trialId == 0 then
        local previousTrialId = playerTrialData.trialData[trialSlot].trialId

        playerTrialData.slotLookup[previousTrialId] = nil
    end

    playerTrialData.trialData[trialSlot].trialId        = trialId
    playerTrialData.trialData[trialSlot].progress       = progress or 0
    playerTrialData.trialData[trialSlot].objectiveTotal = xi.magian.trials[trialId].numRequired

    local packedData = bit.lshift(trialId, 16) + progress

    player:setCharVar("[trial]" .. trialSlot, packedData)
end

-- Returns a packed table of active trials, two per index, along with total count of active trials.  Active trials
-- are determined by a non-zero value for trialId in the cached data.
local function packActiveTrials(player)
    local activeTrials = {}
    local playerTrials = getPlayerTrialData(player)

    for _, trialSlot in pairs(playerTrials.trialData) do
        if trialSlot.trialId > 0 then
            table.insert(activeTrials, trialSlot.trialId)
        end
    end

    local packedData = { 0, 0, 0, 0, 0 }

    for paramIndex = 1, #activeTrials, 2 do
        packedData[(paramIndex + 1) / 2] = activeTrials[paramIndex] + bit.lshift((activeTrials[paramIndex + 1] or 0), 16)
    end

    return packedData, #activeTrials
end

-- Returns a packed 5 bit value and 11 bit identifier of a single augment.  Expected input is a table in the format
-- of { augmentId, augmentValue }
local function packAugment(augmentTable)
    return bit.lshift(augmentTable[2], 11) + augmentTable[1]
end

-- Returns a table containing two packed 32bit parameters corresponding to { Augment1+Augment2, Augment3+Augment4 }
local function packAugmentParameters(augmentTable)
    local packedAugments = { 0, 0 }

    if augmentTable then
        for augIndex, augData in pairs(augmentTable) do
            local packedIndex = math.ceil(augIndex / 2)
            local shiftAmount = augIndex % 2 == 1 and 16 or 0

            packedAugments[packedIndex] = bit.lshift(packAugment(augData), shiftAmount)
        end
    end

    return packedAugments
end

local function getRequiredTradeItem(trialId)
    local tradeItem = xi.magian.trials[trialId].tradeItem

    return tradeItem and tradeItem or 0
end

-- Build table keyed by parent containing all child trials.
local function buildMagianLookupTables()
    local relationTable = {}
    local requiredItemTable = {}

    print("magian: Building lookup tables")

    for trialId, trialData in pairs(xi.magian.trials) do
        -- Build Parent-Child Table
        if not relationTable[trialData.previousTrial] then
            relationTable[trialData.previousTrial] = {}
        end

        table.insert(relationTable[trialData.previousTrial], trialId)

        -- Build Item+Augment to Trial Table
        local itemId = trialData.requiredItem.itemId
        local augKey1, augKey2 = unpack(packAugmentParameters(trialData.requiredItem.itemAugments))

        if not requiredItemTable[itemId] then
            requiredItemTable[itemId] = {}
        end

        if not requiredItemTable[itemId][augKey1] then
            requiredItemTable[itemId][augKey1] = {}
        end

        if not requiredItemTable[itemId][augKey1][augKey2] then
            requiredItemTable[itemId][augKey1][augKey2] = {}
        end

        table.insert(requiredItemTable[itemId][augKey1][augKey2], trialId)
    end

    return relationTable, requiredItemTable
end

xi.magian.trialChildren, xi.magian.requiredItemsToTrial = buildMagianLookupTables()

-- Given Item ID, if exists in xi.magian.requiredItemsToTrial, return its table
local function getAvailableTrials(itemObj)
    local itemId       = itemObj:getID()
    local augmentTable = {}

    -- TODO: Create binding to return table of augments
    for augSlot = 0, 3 do
        augmentTable[augSlot + 1] = itemObj:getAugment(augSlot)
    end

    local augKey1 = bit.lshift(augmentTable[1], 16) + augmentTable[2]
    local augKey2 = bit.lshift(augmentTable[3], 16) + augmentTable[4]

    -- TODO: Find a better way to check if all of these indices exist
    if
        xi.magian.requiredItemsToTrial[itemId] and
        xi.magian.requiredItemsToTrial[itemId][augKey1] and
        xi.magian.requiredItemsToTrial[itemId][augKey1][augKey2]
    then
        return xi.magian.requiredItemsToTrial[itemId][augKey1][augKey2]
    end

    return {}
end

-----------------------------------
-- Global NPC Functions
-----------------------------------
xi.magian.magianOnTrade = function(player, npc, trade)
    if xi.settings.main.ENABLE_MAGIAN_TRIALS ~= 1 then
        return
    end

    local moogleData         = magianMoogleInfo[npc:getName()]
    local itemObj            = trade:getItem()
    local itemId             = trade:getItemId()
    local availableTrials    = getAvailableTrials(itemObj)
    local _, numActiveTrials = packActiveTrials(player)
    local trialId            = itemObj:getTrialNumber()
    local trialData          = xi.magian.trials[trialId]

    player:setLocalVar("storeItemId", itemId)

    if
        player:hasKeyItem(xi.ki.MAGIAN_TRIAL_LOG) and
        trade:getSlotCount() == 1
    then
        if
            #availableTrials == 0 and
            itemObj:isType(moogleData[7])
        then
            -- Invalid/Unsupported Item was Traded
            player:setLocalVar("invalidItem", 1)
            player:startEvent(moogleData[4], 0, 0, 0, 0, 0, 0, 0, utils.MAX_UINT32)

            return
        elseif
            numActiveTrials >= 10 and
            trialId == 0
        then
            -- Player cannot undertake more than 10 trials, and has attempted
            -- to start another.
            player:startEvent(moogleData[4], 0, 0, 0, 0, 0, 0, 0, utils.MAX_UINT32 - 254)

            return
        elseif trialId ~= 0 then
            local playerTrialCache = getPlayerTrialData(player)

            for _, slotData in pairs(playerTrialCache.trialData) do
                if slotData.trialId == trialId then
                    player:setLocalVar("storeTrialId", trialId)
                    -- player:tradeComplete()

                    if slotData.progress >= slotData.objectiveTotal then
                        -- Trial has been completed
                        player:startEvent(moogleData[6], 0, 0, 0, trialData.rewardItem, 0, 0, 0, itemId)
                    else
                        -- Display status of selected trial
                        -- TODO: v was always a table, determine what value is expected here
                        player:startEvent(moogleData[5], trialId, itemId, 0, 0, v, 0, 0, utils.MAX_UINT32 - 1)
                    end

                    return
                end
            end

            -- Item has a trial, but no data is stored on the player
            player:setLocalVar("storeTrialId", trialId)
            player:startEvent(moogleData[5], trialId, trialData.reqItem, 0, 0, 0, 0, 0, utils.MAX_UINT32 - 2)
            -- player:tradeComplete()

            return

        elseif #availableTrials > 0 then
            player:setLocalVar("storeTrialId", availableTrials[1])
            player:tradeComplete()
            player:startEvent(moogleData[4], availableTrials[1], availableTrials[2], availableTrials[3], availableTrials[4], 0, itemId) -- starts trial

            return
        else
            -- TODO: This message should change based on Moogle that has been interacted with
            player:messageSpecial(ruludeID.text.ITEM_NOT_WEAPON_MAGIAN)
        end
    end
end

xi.magian.magianOnTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MAGIAN_TRIALS ~= 1 then
        return
    end

    local moogleData = magianMoogleInfo[npc:getName()]

    if
        moogleData[1] and
        player:getMainLvl() < 75
    then
        player:startEvent(moogleData[1])
    elseif not player:hasKeyItem(xi.ki.MAGIAN_TRIAL_LOG) then
        player:startEvent(moogleData[2])
    else
        local packedData, numActiveTrials = packActiveTrials(player)

        player:startEvent(moogleData[3], packedData[1], packedData[2], packedData[3], packedData[4], packedData[5], 0, 0, numActiveTrials)
    end
end

xi.magian.magianEventUpdate = function(player, csid, option, npc)
    print("Full Option: " .. option)
    local updateType = bit.band(option, 0xFF)
    print("Update Type: " .. updateType)
    switch (updateType): caseof
    {
        [1] = function()
            local trialId   = bit.rshift(option, 16)
            local trialData = xi.magian.trials[trialId]

            local augParam1, augParam2 = unpack(packAugmentParameters(trialData.requiredItem.itemAugments))
            local tradeItem            = getRequiredTradeItem(trialId)

            player:updateEvent(2, augParam1, augParam2, trialData.requiredItem.itemId, 0, tradeItem, trialData.textOffset)
        end,

        [2] = function()
            local trialId   = bit.rshift(option, 16)
            local trialData = xi.magian.trials[trialId]

            local progress        = getTrialProgress(player, trialId)
            local tradeItem       = getRequiredTradeItem(trialId)
            local requiredElement = trialData.requiredElement and trialData.requiredElement or 0

            player:updateEvent(trialData.numRequired, 0, progress, 0, 0, tradeItem, requiredElement)
        end,

        -- Send information regarding the Reward Item
        [3] = function()
            local trialId = bit.rshift(option, 16)
            local trialData = xi.magian.trials[trialId]

            local augParam1, augParam2 = unpack(packAugmentParameters(trialData.rewardItem.itemAugments))
            local tradeItem            = getRequiredTradeItem(trialId)

            player:updateEvent(2, augParam1, augParam2, trialData.rewardItem.itemId, 0, tradeItem)
        end,

        -- Display Available Trials for the provided Item
        [4] = function()
            local trialId    = bit.rshift(option, 16)
            local trialData  = xi.magian.trials[trialId]
            local nextTrials = xi.magian.trialChildren[trialId]
            local tradeItem  = getRequiredTradeItem(trialId)

            if nextTrials then
                -- TODO: We might need to nil check here for each index, though most likely nil value passed will be converted to 0 in binding
                player:updateEvent(nextTrials[1], nextTrials[2], nextTrials[3], nextTrials[4], trialData.previousTrial, tradeItem)
            end
        end,

        -- Lists Trials to Abandon
        [5] = function()
            local packedTrials, trialCount = packActiveTrials(player)

            player:updateEvent(packedTrials[1], packedTrials[2], packedTrials[3], packedTrials[4], packedTrials[5], 0, 0, trialCount)
        end,

        -- Abandon Selected Trial
        [6] = function()
            local trialId   = bit.rshift(option, 8)
            local trialSlot = getTrialSlot(player, trialId)

            if trialSlot then
                player:updateEvent(0, 0, 0, 0, 0, trialSlot)
                updatePlayerTrial(player, trialSlot, 0, 0)
            end
        end,

        -- Checks if Trial is already in progress
        [7] = function()
            local trialId   = bit.rshift(option, 8)
            local trialData = xi.magian.trials[trialId]

            local augParam1, augParam2 = unpack(packAugmentParameters(trialData.requiredItem.itemAugments))
            local trialSlot            = getTrialSlot(player, trialId)

            if trialSlot then
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, utils.MAX_UINT32)
                return
            end

            player:updateEvent(2, augParam1, augParam2, trialData.requiredItem.itemId)
        end,

        -- Abandon Trial through Trade (Options 8 and 11)
        [8] = function()
            local trialId   = bit.rshift(option, 8)
            local trialData = xi.magian.trials[trialId]

            player:updateEvent(0, 0, 0, trialData.requiredItem.itemId)
        end,

        [11] = function()
            local trialId   = bit.rshift(option, 8)
            local trialData = xi.magian.trials[trialId]

            player:updateEvent(0, 0, 0, trialData.requiredItem.itemId)
        end,

        -- Checks if Item's Level will increase
        [13] = function()
            local trialId      = bit.rshift(option, 8)
            local trialData    = xi.magian.trials[trialId]
            local requiredItem = GetReadOnlyItem(trialData.requiredItem.itemId)
            local rewardItem   = GetReadOnlyItem(trialData.rewardItem.itemId)

            if requiredItem:getReqLvl() < rewardItem:getReqLvl() then
                player:updateEvent(1)
            else
                player:updateEvent(0)
            end
        end,

        -- Checks if player already has Reward Item, and Item is Rare
        [14] = function()
            local trialId   = bit.rshift(option, 8)
            local trialData = xi.magian.trials[trialId]
            local rewardObj = player:findItem(trialData.rewardItem.itemId)

            if
                rewardObj and
                bit.band(rewardObj:getFlags(), 0x8000) == 1
            then
                player:updateEvent(1)
            else
                player:updateEvent(0)
            end
        end,
    }
end

xi.magian.magianOnEventFinish = function(player, csid, option, npc)

end
