-----------------------------------
-- Magian Trial Global
-----------------------------------
require('scripts/globals/common')
require('scripts/globals/items')
require('scripts/globals/magian_data')
require('scripts/globals/npc_util')
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

-- NOTE: The below giveXItem functions are global for access in GM command
-- as well as internal usage in this script.

-- TODO: Reduce duplicated code in below two functions
xi.magian.giveRequiredItem = function(player, trialId, inscribeTrialId)
    local itemData = xi.magian.trials[trialId].requiredItem
    local itemParameters = { itemData.itemId, 1, 0, 0, 0, 0, 0, 0, 0, 0, inscribeTrialId and trialId or 0 }

    for augIndex, augData in itemData.itemAugments do
        itemParameters[augIndex + 2] = augData[1]
        itemParameters[augIndex + 3] = augData[2]
    end

    player:addItem(unpack(itemParameters))
end

xi.magian.giveRewardItem = function(player, trialId)
    local itemData = xi.magian.trials[trialId].rewardItem
    local itemParameters = { itemData.itemId, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 }

    for augIndex, augData in itemData.itemAugments do
        itemParameters[augIndex + 2] = augData[1]
        itemParameters[augIndex + 3] = augData[2]
    end

    player:addItem(unpack(itemParameters))
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
                        local v = 1 -- Test
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
    local moogleData = magianMoogleInfo[npc:getName()]
    local finishType = bit.band(option, 0xFF)

    -- TODO: 1073741824 is returned on cancelling event.  This needs to be
    -- handled to return original item if traded.

    if
        csid == moogleData[2] and
        option == 1
    then
        npcUtil.giveKeyItem(player, xi.ki.MAGIAN_TRIAL_LOG)
    elseif csid == moogleData[4] then
        if finishType == 7 then
            -- Start a new trial for an Item

            local trialId   = bit.rshift(option, 8)
            local trialInfo = xi.magian.trials[trialId]

            xi.magian.giveRequiredItem(player, trialId, true)
            player:messageSpecial(ruludeID.text.RETURN_MAGIAN_ITEM, trialInfo.requiredItem.itemId)
            updatePlayerTrial(player, getAvailableTrialSlot(player), trialId, 0)

            -- TODO: These are unused here, and we should probably add some validation
            player:setLocalVar("storeTrialId", 0)
            player:setLocalVar("storeItemId", 0)
        elseif
            finishType == 0 or
            finishType == utils.MAX_UINT32
        then
            local trialId   = player:getLocalVar("storeTrialId")
            local trialInfo = xi.magian.trials[trialId]

            if player:getLocalVar("invalidItem") ~= 1 then
                xi.magian.giveRequiredItem(player, trialId, true)
            end

            player:messageSpecial(ruludeID.text.RETURN_MAGIAN_ITEM, trialInfo.requiredItem.itemId)
            player:setLocalVar("invalidItem", 0)
            player:setLocalVar("storeTrialId", 0)
            player:setLocalVar("storeItemId", 0)
        end
    elseif csid == moogleData[5] then
        if
            finishType == 0 or
            finishType == 4
        then
            -- Return item to the player

            local trialId   = player:getLocalVar("storeTrialId")
            local trialInfo = xi.magian.trials[trialId]

            xi.magian.giveRequiredItem(player, trialId, true)
            player:messageSpecial(ruludeID.text.RETURN_MAGIAN_ITEM, trialInfo.requiredItem.itemId)

            player:setLocalVar("storeTrialId", 0)
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

        local trialId    = player:getLocalVar("storeTrialId")
        local trialInfo  = xi.magian.trials[trialId]
        local activeSlot = getTrialSlot(player, trialId)

        if activeSlot then
            updatePlayerTrial(player, activeSlot, 0, 0)
        end

        xi.magian.giveRewardItem(player, trialId)
        player:messageSpecial(ruludeID.text.ITEM_OBTAINED, trialInfo.rewardItem.itemId)

        player:setLocalVar("storeTrialId", 0)
    end
end

-----------------------------------
-- Delivery Crate
-----------------------------------

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

    if trialId ~= 0 then
        local trialInfo           = xi.magian.trials[trialId]
        local playerTrialProgress = getTrialProgress(player, trialId)

        if
            playerTrialProgress and
            trialInfo.tradeItem and
            tradeItems[trialInfo.tradeItem]
        then
            local numRemainingItems = trialInfo.numRequired - playerTrialProgress

            trade:confirmItem(trialInfo.tradeItem, math.min(tradeItems[trialInfo.tradeItem], numRemainingItems))
        end
    end

    -- TODO: Update these based on need
    player:setLocalVar("storeTrialId", trialId)
    -- player:setLocalVar("storeItemId", currentItem.id)
    -- player:setLocalVar("storeItemTrialId", currentItemTrial.id)
    -- player:setLocalVar("storeItemTrialQty", currentItemTrial.quantity)

    -- TODO: If this is just the number of active trials, replace with lookup function
    player:setLocalVar("storeNbTrialsPlayer", nbTrialsPlayer)

    player:confirmTrade()
    player:startEvent(10134, currentItemTrial.id, currentItemTrial.quantity, nbTrialsPlayer, currentTrialId, 0, 0, 0, 0)
end

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

xi.magian.deliveryCrateOnEventUpdate = function(player, csid, option, npc)
    local optionMod      = bit.band(option, 0xFF)
    local itemTrialId    = player:getLocalVar("storeItemTrialId")
    local nbTrialsPlayer = player:getLocalVar("storeNbTrialsPlayer")
    local maxNumber      = 31 -- TODO: What does this do?  I bet this is a bitmask of active trials, and the shift is cheesing it out of scope

    if csid == 10134 then
        if optionMod == 101 then
            player:updateEvent(itemTrialId, 0, 0, 0, 0, 0, maxNumber, 0)

        elseif optionMod == 103 then
            local places            = bit.rshift(maxNumber, nbTrialsPlayer)
            local activeTradeTrials = getPlayerTrialsByTradeItemId(player, itemTrialId)
            local trialParams = {}

            for i = 5, 1, -1 do
                local currentTrial = activeTradeTrials[i]
                
                if currentTrial and currentTrial.trialId ~= 0 then
                    local remainingObjectives = currentTrial.objectiveTotal - currentTrial.progress

                    table.insert(trialParams, bit.lshift(remainingObjectives, 16) + currentTrial.trialId)
                else
                    table.insert(trialParams, 0)
                end
            end

            player:updateEvent(trialParams[1], trialParams[2], trialParams[3], trialParams[4], trialParams[5], nbTrialsPlayer, places, 0)
        end
    end
end

xi.magian.deliveryCrateOnEventFinish = function(player, csid, option)
    local optionMod         = bit.band(option, 0xFF)
    local trialId           = bit.rshift(option, 8)
    local itemTrialId       = player:getLocalVar("storeItemTrialId")
    local itemTrialQuantity = player:getLocalVar("storeItemTrialQty")

    if csid == 10134 then
        if optionMod == 0 then
            player:messageSpecial(ruludeID.text.RETURN_ITEM, itemTrialId)
        elseif optionMod == 102 then
            checkAndSetProgression(player, trialId, { itemId = itemTrialId, quantity = itemTrialQuantity }, xi.settings.main.MAGIAN_TRIALS_TRADE_MULTIPLIER)
        end

        -- TODO: Find out what's really necessary for all of these locals
        if
            optionMod == 0 or
            optionMod == 102
        then
            player:setLocalVar("storeTrialId", 0)
            player:setLocalVar("storeItemId", 0)
            player:setLocalVar("storeItemTrialId", 0)
            player:setLocalVar("storeItemTrialQty", 0)
            player:setLocalVar("storeNbTrialsPlayer", 0)
        end
    end
end

-----------------------------------
-- Item Globals/Callbacks
-----------------------------------
xi.magian.onItemEquip = function(player, item)
    -- If not Trial on Item, return
    -- Find major listener required for item
    -- Apply generic listener, also checking sub-requirements based on table contents
    -- Add listener, unique ID: TRIALxxxx

    -- Initial version: Do we just cache trial IDs and check everywhere?
end

xi.magian.onItemUnequip = function(player, item)
    -- Check if item equipped in cache?
    -- remove listener
end

xi.magian.onMobDeath = function(mob, player, optParams, trialTable)
    -- For each in trialTable, if not noKiller and cached active trialTable[x], add progress
end
