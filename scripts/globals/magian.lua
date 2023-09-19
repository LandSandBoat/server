-----------------------------------
-- Magian Trial Global
-----------------------------------
require('scripts/globals/magian_data')
require('scripts/globals/npc_util')
-----------------------------------
local ruludeID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------
xi = xi or {}
xi.magian = xi.magian or {}

-- NOTE: This table should never be accessed directly, and is not guaranteed to contain
-- data unless returned via getPlayerTrialData().
xi.magian.playerCache = xi.magian.playerCache or {}

local magianMoogleInfo =
{
    ['Magian_Moogle_Blue']   = {   nil, 10141, 10142, 10143, 10144, 10148, xi.itemType.ARMOR  },
    ['Magian_Moogle_Orange'] = { 10121, 10122, 10123, 10124, 10125, 10129, xi.itemType.WEAPON },
}

-- Returns a table of data containing the player's currently active trials, and caches this data
-- keyed by player ID into xi.magian.playerCache.
local function getPlayerTrialData(player)
    local playerId  = player:getID()
    local trialData = xi.magian.playerCache[playerId]

    -- NOTE: This cached data may vary across processes, therefore as a safety measure, refresh
    -- the cache any time the player has zoned.
    if
        trialData and
        player:getLocalVar('magianZoned') == 1
    then
        return trialData
    end

    trialData        = {}
    local slotLookup = {}

    for trialSlot = 1, 10 do
        local packedTrial    = player:getCharVar('[trial]' .. trialSlot)
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

    player:setLocalVar('magianZoned', 1)

    return xi.magian.playerCache[playerId]
end

local function getTrialProgress(player, trialId)
    local playerTrials = getPlayerTrialData(player)
    local trialSlot    = playerTrials.slotLookup[trialId]

    if trialSlot then
        return playerTrials.trialData[trialSlot].progress
    end

    return nil
end

-- Returns the Index of first available Trial Slot
local function getAvailableTrialSlot(player)
    local playerTrials = getPlayerTrialData(player)

    for trialSlot, trialData in ipairs(playerTrials.trialData) do
        if trialData.trialId == 0 then
            return trialSlot
        end
    end
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
    else
        playerTrialData.slotLookup[trialId] = trialSlot
    end

    playerTrialData.trialData[trialSlot].trialId        = trialId
    playerTrialData.trialData[trialSlot].progress       = progress or 0
    playerTrialData.trialData[trialSlot].objectiveTotal = xi.magian.trials[trialId] and xi.magian.trials[trialId].numRequired or 0

    local packedData = bit.lshift(trialId, 16) + progress

    player:setCharVar('[trial]' .. trialSlot, packedData)
end

local function progressPlayerTrial(player, trialId, progressAmt)
    local activeTrials = getPlayerTrialData(player)
    local trialSlot    = activeTrials.slotLookup[trialId]

    if
        trialSlot and
        activeTrials.trialData[trialSlot].progress < activeTrials.trialData[trialSlot].objectiveTotal
    then
        updatePlayerTrial(player, trialSlot, trialId, activeTrials.trialData[trialSlot].progress + progressAmt)

        local remainingObjectives = activeTrials.trialData[trialSlot].objectiveTotal - activeTrials.trialData[trialSlot].progress
        if remainingObjectives == 0 then
            player:messageBasic(xi.msg.basic.MAGIAN_TRIAL_COMPLETE, trialId)
        else
            player:messageBasic(xi.msg.basic.MAGIAN_TRIAL_COMPLETE - 1, trialId, remainingObjectives)
        end
    end
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

            packedAugments[packedIndex] = packedAugments[packedIndex] + bit.lshift(packAugment(augData), shiftAmount)
        end
    end

    return packedAugments
end

local function getRequiredTradeItem(trialId)
    local tradeItem = xi.magian.trials[trialId].tradeItem

    return tradeItem and tradeItem or 0
end

-- Tables are always passed by reference.  We're going to exploit this a bit here
-- in order to safely insert a value into a nested table structure.
local function insertOrCreate(targetTable, tableIndices, value)
    local subTable = targetTable

    for tableIndex = 1, #tableIndices do
        local indexValue = tableIndices[tableIndex]

        if not subTable[indexValue] then
            subTable[indexValue] = {}
        end

        if tableIndex == #tableIndices then
            table.insert(subTable[indexValue], value)
        end

        subTable = subTable[indexValue]
    end
end

local function getNestedValue(targetTable, tableIndices)
    local subTable = targetTable

    for tableIndex = 1, #tableIndices do
        local indexValue = tableIndices[tableIndex]

        if not subTable[indexValue] then
            return nil
        end

        if tableIndex == #tableIndices then
            return subTable[indexValue]
        end

        subTable = subTable[indexValue]
    end
end

-- Build table keyed by parent containing all child trials.
local function buildMagianLookupTables()
    local relationTable = {}
    local requiredItemTable = {}

    for trialId, trialData in pairs(xi.magian.trials) do
        -- Build Parent-Child Table
        if not relationTable[trialData.previousTrial] then
            relationTable[trialData.previousTrial] = {}
        end

        table.insert(relationTable[trialData.previousTrial], trialId)

        -- Build Item + Augment to Trial Table
        local itemId     = trialData.requiredItem.itemId
        local lookupKeys = { itemId, 0, 0, 0, 0 }

        if trialData.requiredItem.itemAugments then
            for augmentPos = 1, #trialData.requiredItem.itemAugments do
                lookupKeys[augmentPos + 1] = packAugment(trialData.requiredItem.itemAugments[augmentPos])
            end
        end

        insertOrCreate(requiredItemTable, lookupKeys, trialId)
    end

    return relationTable, requiredItemTable
end

-- Set onEquip and onUnequip functions for trial items that require
-- a listener.  This avoids having to create an item file for every magian item,
-- since onItemEquip/unEquip functions only exist for two items.
-- NOTE: This function isn't the most efficient, but is only executed on server
-- start, or magian reload.
local function registerTrialListeners()
    xi.items = xi.items or {}

    for trialId, magianData in pairs(xi.magian.trials) do
        if
            magianData.defeatMob or
            magianData.gainExp or
            magianData.useWeaponskill
        then
            for itemKey, itemId in pairs(xi.item) do
                if magianData.requiredItem.itemId == itemId then
                    local itemName = string.lower(itemKey)

                    xi.items[itemName]                  = xi.items[itemName] or {}
                    xi.items[itemName]['onItemEquip']   = xi.magian.onItemEquip
                    xi.items[itemName]['onItemUnequip'] = xi.magian.onItemUnequip
                    break
                end
            end
        end
    end
end

xi.magian.trialChildren, xi.magian.requiredItemsToTrial = buildMagianLookupTables()

-- Given Item ID, if exists in xi.magian.requiredItemsToTrial, return its table
local function getAvailableTrials(itemObj)
    local itemId     = itemObj:getID()
    local lookupKeys = { itemId, 0, 0, 0, 0 }

    -- TODO: Create binding to return table of augments
    for augSlot = 0, 3 do
        lookupKeys[augSlot + 2] = packAugment(itemObj:getAugment(augSlot))
    end

    return getNestedValue(xi.magian.requiredItemsToTrial, lookupKeys) or {}
end

-----------------------------------
-- Global NPC Functions
-----------------------------------

local function giveMagianItem(player, itemData, inscribeTrialId)
    local itemParameters = { itemData.itemId, 1, 0, 0, 0, 0, 0, 0, 0, 0, inscribeTrialId and inscribeTrialId or 0 }

    if itemData.itemAugments then
        for augIndex, augData in pairs(itemData.itemAugments) do
            itemParameters[augIndex * 2 + 1] = augData[1]
            itemParameters[augIndex * 2 + 2] = augData[2]
        end
    end

    player:addItem(unpack(itemParameters))
end

xi.magian.giveRequiredItem = function(player, trialId, inscribeTrialId)
    giveMagianItem(player, xi.magian.trials[trialId].requiredItem, inscribeTrialId == true and trialId or 0)
end

xi.magian.giveRewardItem = function(player, trialId)
    giveMagianItem(player, xi.magian.trials[trialId].rewardItem, false)
end

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

    if
        player:hasKeyItem(xi.ki.MAGIAN_TRIAL_LOG) and
        trade:getSlotCount() == 1 and
        itemObj:isType(moogleData[7])
    then
        if #availableTrials == 0 then
            -- Invalid/Unsupported Item was Traded
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
                    player:setLocalVar('storeTrialId', trialId)
                    player:tradeComplete()

                    if slotData.progress >= slotData.objectiveTotal then
                        -- Trial has been completed
                        player:startEvent(moogleData[6], 0, 0, 0, trialData.rewardItem, 0, 0, 0, itemId)
                    else
                        -- Display status of selected trial
                        -- TODO: v was always a table which would be 0 from bindings, determine what value is expected here.
                        -- Defaulting to 0 and leaving the variable to mark position for future research.
                        local v = 0 -- Test
                        player:startEvent(moogleData[5], trialId, itemId, 0, 0, v, 0, 0, utils.MAX_UINT32 - 1)
                    end

                    return
                end
            end

            -- Item has a trial, but no data is stored on the player
            player:setLocalVar('storeTrialId', trialId)
            player:startEvent(moogleData[5], trialId, trialData.reqItem, 0, 0, 0, 0, 0, utils.MAX_UINT32 - 2)
            player:tradeComplete()

            return

        elseif #availableTrials > 0 then
            player:setLocalVar('storeTrialId', availableTrials[1])
            player:tradeComplete()
            player:startEvent(moogleData[4], availableTrials[1], availableTrials[2], availableTrials[3], availableTrials[4], 0, itemId)

            return
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
    local updateType = bit.band(option, 0xFF)

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
            local requiredElement = trialData.requiredElement and trialData.requiredElement or 0
            local optParam        = 0

            -- NOTE: optParam value is required for certain messages, and even though
            -- this system can support more complex combinations, it may not display correctly
            -- if customizing.
            if trialData.tradeItem then
                optParam = getRequiredTradeItem(trialId)
            elseif trialData.minDamage then
                optParam = trialData.minDamage
            elseif trialData.dayWeather then
                optParam = trialData.dayWeather
            end

            player:updateEvent(trialData.numRequired, 0, progress, 0, 0, optParam, requiredElement)
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
            local nextTrials = xi.magian.trialChildren[trialId] or { 0, 0, 0, 0 }
            local tradeItem  = getRequiredTradeItem(trialId)

            player:updateEvent(nextTrials[1], nextTrials[2], nextTrials[3], nextTrials[4], trialData.previousTrial, tradeItem)
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
                bit.band(rewardObj:getFlag(), 0x8000) == 1
            then
                player:updateEvent(1)
            else
                player:updateEvent(0)
            end
        end,
    }
end

xi.magian.magianOnEventFinish = function(player, csid, option, npc)
    local moogleData = magianMoogleInfo[npc:getName()]
    local finishType = bit.band(option, 0xFF)

    if
        csid == moogleData[2] and
        option == 1
    then
        npcUtil.giveKeyItem(player, xi.ki.MAGIAN_TRIAL_LOG)
    elseif csid == moogleData[4] then
        -- Trial Item Traded without Trial Inscribed

        if finishType == 7 then
            -- Start a new trial for an Item

            local trialId   = bit.rshift(option, 8)
            local trialInfo = xi.magian.trials[trialId]

            xi.magian.giveRequiredItem(player, trialId, true)
            player:messageSpecial(ruludeID.text.RETURN_MAGIAN_ITEM, trialInfo.requiredItem.itemId)
            updatePlayerTrial(player, getAvailableTrialSlot(player), trialId, 0)

            player:setLocalVar('storeTrialId', 0)
        elseif
            finishType == 0 or
            finishType == 255
        then
            local trialId       = player:getLocalVar('storeTrialId')
            local trialInfo     = xi.magian.trials[trialId]

            xi.magian.giveRequiredItem(player, trialId, false)

            player:messageSpecial(ruludeID.text.RETURN_MAGIAN_ITEM, trialInfo.requiredItem.itemId)
            player:setLocalVar('storeTrialId', 0)
        end
    elseif csid == moogleData[5] then
        -- Trial Item Traded with a Trial Inscribed

        if
            finishType == 0 or
            finishType == 4
        then
            -- Return item to the player
            local trialId   = player:getLocalVar('storeTrialId')
            local trialInfo = xi.magian.trials[trialId]

            xi.magian.giveRequiredItem(player, trialId, true)
            player:messageSpecial(ruludeID.text.RETURN_MAGIAN_ITEM, trialInfo.requiredItem.itemId)

            player:setLocalVar('storeTrialId', 0)
        elseif
            finishType == 8 or
            finishType == 11
        then
            -- Remove Trial ID and return item to the player

            local trialId    = bit.rshift(option, 8)
            local trialInfo  = xi.magian.trials[trialId]
            local activeSlot = getTrialSlot(player, trialId)

            if activeSlot then
                updatePlayerTrial(player, activeSlot, 0, 0)
            end

            xi.magian.giveRequiredItem(player, trialId, false)
            player:messageSpecial(ruludeID.text.RETURN_MAGIAN_ITEM, trialInfo.requiredItem.itemId)
        end
    elseif
        csid == moogleData[6] and
        finishType == 0
    then
        -- Complete Active Trial
        local trialId    = player:getLocalVar('storeTrialId')
        local trialInfo  = xi.magian.trials[trialId]
        local activeSlot = getTrialSlot(player, trialId)

        if activeSlot then
            updatePlayerTrial(player, activeSlot, 0, 0)
        end

        xi.magian.giveRewardItem(player, trialId)
        player:messageSpecial(ruludeID.text.ITEM_OBTAINED, trialInfo.rewardItem.itemId)

        player:setLocalVar('storeTrialId', 0)
    end
end

-----------------------------------
-- Delivery Crate
-----------------------------------

-- Get the active trials which requires the traded item in parameter
local function getPlayerTrialsByTradeItemId(player, itemId)
    local activeTrials = getPlayerTrialData(player)
    local resultTrials = {}

    for trialId, trialSlot in pairs(activeTrials.slotLookup) do
        if
            itemId == xi.magian.trials[trialId].tradeItem and
            activeTrials.trialData[trialSlot].progress < activeTrials.trialData[trialSlot].objectiveTotal
        then
            table.insert(resultTrials, activeTrials.trialData[trialSlot])
        end
    end

    return resultTrials
end

xi.magian.deliveryCrateOnTrade = function(player, npc, trade)
    local trialId    = 0
    local tradeItems = {}

    for tradeSlot = 0, 7 do
        local itemObj = trade:getItem(tradeSlot)

        if itemObj then
            local itemId      = itemObj:getID()
            local itemTrialId = itemObj:getTrialNumber()

            if
                itemTrialId ~= 0 and
                trialId == 0 and
                xi.magian.trials[itemTrialId] and
                xi.magian.trials[itemTrialId].tradeItem
            then
                -- NOTE: First in Wins, and we ignore any other item with a trial
                trialId = itemTrialId
            elseif not tradeItems[itemId] then
                tradeItems[itemId] = trade:getItemQty(itemId)
            end
        end
    end

    local trialInfo           = xi.magian.trials[trialId]
    local playerTrialProgress = getTrialProgress(player, trialId)

    if
        trialId ~= 0 and
        playerTrialProgress and
        trialInfo.tradeItem and
        tradeItems[trialInfo.tradeItem]
    then
        local numRelevantTrials = #getPlayerTrialsByTradeItemId(player, trialInfo.tradeItem)
        local numRemainingItems = trialInfo.numRequired - playerTrialProgress
        local numItemsTraded    = math.min(tradeItems[trialInfo.tradeItem], numRemainingItems)

        trade:confirmItem(trialInfo.tradeItem, numItemsTraded)

        player:setLocalVar('storeTrialId', trialId)
        player:setLocalVar('tradedItemId', trialInfo.tradeItem)
        player:setLocalVar('tradedItemQty', numItemsTraded)

        player:confirmTrade()
        player:startEvent(10134, trialInfo.tradeItem, numItemsTraded, numRelevantTrials, trialId, 0, 0, 0, 0)
    end
end

xi.magian.deliveryCrateOnEventUpdate = function(player, csid, option, npc)
    local optionMod         = bit.band(option, 0xFF)
    local tradedItemId      = player:getLocalVar('tradedItemId')
    local numRelevantTrials = #getPlayerTrialsByTradeItemId(player, tradedItemId)
    local maxNumber         = 31

    if csid == 10134 then
        if optionMod == 101 then
            player:updateEvent(tradedItemId, 0, 0, 0, 0, 0, maxNumber, 0)

        elseif optionMod == 103 then
            local places            = bit.rshift(maxNumber, numRelevantTrials)
            local activeTradeTrials = getPlayerTrialsByTradeItemId(player, tradedItemId)
            local trialParams       = {}

            for i = 5, 1, -1 do
                local currentTrial = activeTradeTrials[i]

                if currentTrial and currentTrial.trialId ~= 0 then
                    local remainingObjectives = currentTrial.objectiveTotal - currentTrial.progress

                    table.insert(trialParams, bit.lshift(remainingObjectives, 16) + currentTrial.trialId)
                else
                    table.insert(trialParams, 0)
                end
            end

            player:updateEvent(trialParams[1], trialParams[2], trialParams[3], trialParams[4], trialParams[5], numRelevantTrials, places, 0)
        end
    end
end

xi.magian.deliveryCrateOnEventFinish = function(player, csid, option)
    local optionMod     = bit.band(option, 0xFF)
    local trialId       = bit.rshift(option, 8)
    local tradedItemId  = player:getLocalVar('tradedItemId')
    local tradedItemQty = player:getLocalVar('tradedItemQty')

    if csid == 10134 then
        if optionMod == 0 then
            player:messageSpecial(ruludeID.text.RETURN_ITEM, tradedItemId)
        elseif optionMod == 102 then
            progressPlayerTrial(player, trialId, tradedItemQty)
        end

        if
            optionMod == 0 or
            optionMod == 102
        then
            player:setLocalVar('storeTrialId', 0)
            player:setLocalVar('tradedItemId', 0)
            player:setLocalVar('tradedItemQty', 0)
        end
    end
end

-- [elementId] = { validDay, { weatherEffect1, weatherEffect2 } },
local dayWeatherElement =
{
    [xi.element.FIRE   ] = { xi.day.FIRESDAY,     { xi.weather.HOT_SPELL,  xi.weather.HEAT_WAVE     } },
    [xi.element.ICE    ] = { xi.day.ICEDAY,       { xi.weather.SNOW,       xi.weather.BLIZZARDS     } },
    [xi.element.WIND   ] = { xi.day.WINDSDAY,     { xi.weather.WIND,       xi.weather.GALES         } },
    [xi.element.EARTH  ] = { xi.day.EARTHSDAY,    { xi.weather.DUST_STORM, xi.weather.SAND_STORM    } },
    [xi.element.THUNDER] = { xi.day.LIGHTNINGDAY, { xi.weather.THUNDER,    xi.weather.THUNDERSTORMS } },
    [xi.element.WATER  ] = { xi.day.WATERSDAY,    { xi.weather.RAIN,       xi.weather.SQUALL        } },
    [xi.element.LIGHT  ] = { xi.day.LIGHTSDAY,    { xi.weather.AURORAS,    xi.weather.STELLAR_GLARE } },
    [xi.element.DARK   ] = { xi.day.DARKSDAY,     { xi.weather.GLOOM,      xi.weather.DARKNESS      } },
}

local elementData =
{
    [xi.magianElement.FIRE     ] = { xi.element.FIRE    },
    [xi.magianElement.ICE      ] = { xi.element.ICE     },
    [xi.magianElement.WIND     ] = { xi.element.WIND    },
    [xi.magianElement.EARTH    ] = { xi.element.EARTH   },
    [xi.magianElement.THUNDER  ] = { xi.element.THUNDER },
    [xi.magianElement.WATER    ] = { xi.element.WATER   },
    [xi.magianElement.LIGHT    ] = { xi.element.LIGHT   },
    [xi.magianElement.DARK     ] = { xi.element.DARK    },
    [xi.magianElement.ANY_LIGHT] =
    {
        xi.element.FIRE,
        xi.element.WIND,
        xi.element.THUNDER,
        xi.element.LIGHT,
    },

    [xi.magianElement.ANY_DARK] =
    {
        xi.element.ICE,
        xi.element.EARTH,
        xi.element.WATER,
        xi.element.DARK,
    },

    [xi.magianElement.ANY] =
    {
        xi.element.FIRE,
        xi.element.ICE,
        xi.element.WIND,
        xi.element.EARTH,
        xi.element.THUNDER,
        xi.element.WATER,
        xi.element.LIGHT,
        xi.element.DARK,
    },
}

local trialConditions =
{
    -- NOTE: This condition is a bit of an outlier, as it is both a condition and
    -- can have a higher reward value as opposed to a credit of 1.  Light and Dark are special exceptions
    -- that should be handled in magian trial data, if it is the case where multiple elements are allowed.
    ['dayWeather'] = function(trialData, player, mob, paramTable)
        if trialData.dayWeather then
            local dayWeatherResult = 0
            local dayWeatherTable  = elementData[trialData.dayWeather]

            local currentWeather = player:getWeather(true)
            for _, elementId in ipairs(dayWeatherTable) do
                if dayWeatherElement[elementId][1] == VanadielDayOfTheWeek() then
                    dayWeatherResult = dayWeatherResult + 1
                end

                for _, weatherType in ipairs(dayWeatherElement[elementId][2]) do
                    if weatherType == currentWeather then
                        dayWeatherResult = dayWeatherResult and dayWeatherResult + 5
                        break
                    end
                end
            end

            return dayWeatherResult > 0 and dayWeatherResult or false
        end

        return true
    end,

    ['minDamage'] = function(trialData, player, mob, paramTable)
        return not trialData.minDamage or paramTable.weaponskillDamage >= trialData.minDamage
    end,

    ['mobEcosystem'] = function(trialData, player, mob, paramTable)
        return not trialData.mobEcosystem or mob:getEcosystem() == trialData.mobEcosystem
    end,

    ['mobFamily'] = function(trialData, player, mob, paramTable)
        return not trialData.mobFamily or trialData.mobFamily[mob:getFamily()]
    end,

    ['mobSuperFamily'] = function(trialData, player, mob, paramTable)
        return not trialData.mobSuperFamily or trialData.mobSuperFamily[mob:getSuperFamily()]
    end,

    ['useWeaponskill'] = function(trialData, player, mob, paramTable)
        local weaponskillTable = type(trialData.useWeaponskill) == 'table' and trialData.useWeaponskill or set{ trialData.useWeaponskill }

        return not trialData.useWeaponskill or weaponskillTable[paramTable.weaponskillUsed]
    end,

    ['zoneId'] = function(trialData, player, mob, paramTable)
        return not trialData.zoneId or trialData.zoneId[player:getZoneID()]
    end,
}

local function checkConditions(trialData, player, mob, paramTable)
    local creditReward = 1

    for conditionName, conditionFunc in pairs(trialConditions) do
        local conditionResult = conditionFunc(trialData, player, mob, paramTable)

        if not conditionResult then
            return false
        elseif type(conditionResult) == 'number' then
            creditReward = conditionResult
        end
    end

    return creditReward
end

-----------------------------------
-- Item Globals/Callbacks
-----------------------------------
xi.magian.onItemEquip = function(player, itemObj)
    local itemTrialId = itemObj:getTrialNumber()

    -- If the item has no active trial, or the player has
    -- abandoned the trial, bail out.
    if
        itemTrialId == 0 or
        not getTrialProgress(player, itemTrialId)
    then
        return
    end

    local trialData = xi.magian.trials[itemTrialId]

    if not trialData then
        return
    end

    -- A valid trial exists, so apply the appropriate listener for it.  Defeating a mob is always the highest
    -- priority listener, and if it doesn't apply, only then fall back.  All magian trials with a listener
    -- require the player to both be alive and the mob be experience-granting (NMs are handled separately)

    -- TODO:
    -- Elemental Damage (Anyone counts!)
    -- Pet kill
    -- Avatar Kill (Summon must be out, but another of the same type can cause credit)
    -- While under specific enfeeble
    -- Proc additional effect

    if trialData.defeatMob then
        player:addListener('DEFEATED_MOB', 'TRIAL_' .. itemTrialId, function(mobObj, playerObj, optParams)
            if not playerObj:isDead() and playerObj:checkKillCredit(mobObj) then
                local conditionResult = checkConditions(trialData, playerObj, mobObj, optParams)

                if conditionResult then
                    progressPlayerTrial(playerObj, itemTrialId, conditionResult)
                end
            end
        end)

    elseif trialData.useWeaponskill then
        player:addListener('WEAPONSKILL_USE', 'TRIAL_' .. itemTrialId, function(playerObj, mobObj, weaponskillId, tpSpent, action, damage)
            if not playerObj:isDead() and playerObj:checkKillCredit(mobObj) then
                local conditionResult = checkConditions(trialData, playerObj, mobObj, { weaponskillUsed = weaponskillId, weaponskillDamage = damage })

                if conditionResult then
                    progressPlayerTrial(playerObj, itemTrialId, conditionResult)
                end
            end
        end)

    elseif trialData.gainExp then
        player:addListener('EXPERIENCE_POINTS', 'TRIAL_' .. itemTrialId, function(playerObj, mobObj, expGained)
            if not playerObj:isDead() and playerObj:checkKillCredit(mobObj) then
                if checkConditions(trialData, playerObj, mobObj) then
                    progressPlayerTrial(playerObj, itemTrialId, expGained)
                end
            end
        end)
    end
end

xi.magian.onItemUnequip = function(player, itemObj)
    local itemTrialId = itemObj:getTrialNumber()

    if
        itemTrialId ~= 0 and
        getTrialProgress(player, itemTrialId)
    then
        player:removeListener('TRIAL_' .. itemTrialId)
    end
end

xi.magian.onMobDeath = function(mob, player, optParams, trialTable)
    local relevantTrials = {}

    for equipSlot = xi.slot.MAIN, xi.slot.FEET do
        local itemObj = player:getEquippedItem(equipSlot)

        if itemObj then
            local trialId = itemObj:getTrialNumber()

            if
                trialId > 0 and
                trialTable[trialId]
            then
                table.insert(relevantTrials, trialId)
            end
        end
    end

    for _, trialId in ipairs(relevantTrials) do
        progressPlayerTrial(player, trialId, 1)
    end
end

-- Once everything else is setup, register listeners with the appropriate items
registerTrialListeners()
