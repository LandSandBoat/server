-----------------------------------
-- Magian trials
-----------------------------------
require('scripts/globals/magianobjectives')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.magian = xi.magian or {}

-- trial id and progress
local function getPlayerTrialByIndex(player, i)
    local activeTrials   = getPlayerTrials(player)
    local progress       = activeTrials[i] and activeTrials[i].progress
    local trial          = activeTrials[i] and activeTrials[i].trial
    local objectiveTotal = activeTrials[i] and activeTrials[i].objectiveTotal

    return trial, progress, objectiveTotal
end

-- Get the active trials who requires the item in parameter
local function getPlayerTrialByItemId(player, itemId)
    local trials       = xi.magian.trials
    local trialsPlayer = getPlayerTrials(player)
    local resultTrials = {}

    for index, obj in pairs(trialsPlayer) do
        local trialId = obj.trial

        if
            trials[trialId] and
            trials[trialId].reqs and
            trials[trialId].reqs.itemId and
            trials[trialId].reqs.itemId[itemId] and
            trialsPlayer[index].progress < trialsPlayer[index].objectiveTotal
        then
            table.insert(resultTrials, { trial = trialId, progress = trialsPlayer[index].progress, objectiveTotal = trialsPlayer[index].objectiveTotal })
        end
    end

    return resultTrials
end

-- finds empty trial slot
local function firstEmptySlot(player)
    for i, v in ipairs(getPlayerTrials(player)) do
        if v.trial == 0 then
            return i
        end
    end
end

local function hasTrial(player, trialId)
    for i, v in ipairs(getPlayerTrials(player)) do
        if v.trial == trialId then
            return i, v
        end
    end

    return false
end

local function checkAndSetProgression(player, trialId, conditions, multiplier)
    local trials                   = xi.magian.trials
    local cachePosition, cacheData = hasTrial(player, trialId)

    if trialId and cachePosition then
        local increment = trials[trialId]:check(player, conditions)

        if increment > 0 then
            if cacheData.progress < cacheData.objectiveTotal then
                local newProgress         = math.min(cacheData.progress + (increment * multiplier), cacheData.objectiveTotal)
                local remainingObjectives = cacheData.objectiveTotal - newProgress

                setTrial(player, cachePosition, trialId, newProgress)

                if remainingObjectives == 0 then
                    player:messageBasic(xi.msg.basic.MAGIAN_TRIAL_COMPLETE, trialId) -- trial complete
                else
                    player:messageBasic(xi.msg.basic.MAGIAN_TRIAL_COMPLETE - 1, trialId, remainingObjectives) -- trial <trialid>: x objectives remain
                end

            elseif cacheData.progress > cacheData.objectiveTotal then
                setTrial(player, cachePosition, trialId, cacheData.objectiveTotal)
            end
        end
    end
end

local function checkItemIdExistsInTable(table, itemId)
    for _, v in ipairs(table) do
        if v.id == itemId then
            return true
        end
    end

    return false
end

local function getItemsInTrade(trade)
    local itemsTrials = {}
    local otherItems  = {}

    for i = 0, 7 do
        local item = trade:getItem(i)

        if item then
            local itemId      = item:getID()
            local trialNumber = item:getTrialNumber()

            if trialNumber ~= 0 then
                table.insert(itemsTrials, { id = itemId, trialId = trialNumber })
            elseif not checkItemIdExistsInTable(otherItems, itemId) then
                table.insert(otherItems, { id = itemId, quantity = trade:getItemQty(itemId) })
            end
        end
    end

    return itemsTrials, otherItems
end

local function getTrialsBits(player, trials)
    local trialsBits = {}

    for i = 5, 1, -1 do
        local currentTrial = trials[i]
        if currentTrial and currentTrial.trial ~= 0 then
            local remainingObjectives = currentTrial.objectiveTotal - currentTrial.progress
            table.insert(trialsBits, bit.lshift(remainingObjectives, 16) + currentTrial.trial)
        else
            table.insert(trialsBits, 0)
        end
    end

    return trialsBits
end

local function returnUselessItems(player, items, itemIdException)
    for _, item in ipairs(items) do
        if item.id ~= itemIdException and item.quantity then
            player:addItem(item.id, item.quantity)
        elseif item.id ~= itemIdException and item.trialId then
            local t = GetMagianTrial(item.trialId)
            player:addItem(t.reqItem, 1, t.reqItemAug1, t.reqItemAugValue1, t.reqItemAug2, t.reqItemAugValue2, t.reqItemAug3, t.reqItemAugValue3, t.reqItemAug4, t.reqItemAugValue4, item.trialId)
        end
    end
end

-----------------------------------
-- Delivery Crate
-----------------------------------

xi.magian.deliveryCrateOnTrade = function(player, npc, trade)
    -- items = parts of stuff
    -- itemsTrial = items for trial
    local items, itemsTrial = getItemsInTrade(trade)

    -- get size of tables
    local nbitems      = #items
    local nbitemsTrial = #itemsTrial

    -- playerTrials = active trials for the player
    local nbTrialsPlayer = 0

    -- currentItem = Part of stuff use for event
    local currentItem = { id = 0, quantity = 0 }
    local currentItemTrial = nil

    -- currentTrial = trial use for event
    local currentTrial   = nil
    local currentTrialId = 0

    if nbitemsTrial == 0 then
        return
    end

    if nbitemsTrial >= 1 then
        for i, item in ipairs(itemsTrial) do
            local trials   = getPlayerTrialByItemId(player, item.id)
            local nbtrials = #trials

            if nbtrials > 0 then
                currentTrial = trials[1]
                currentTrialId = trials[1].trial
                currentItemTrial = item
                nbTrialsPlayer = nbtrials
            end
        end
    end

    if nbTrialsPlayer == 0 or currentTrialId == 0 then
        return
    end

    if nbitems > 0 then -- if player trade 1 part of stuff and item
        currentItem = items[1]
    end

    local nbOverItems = (currentTrial.objectiveTotal - currentTrial.progress + currentItemTrial.quantity) * -1

    if nbOverItems > 0 then
        player:addItem(currentItemTrial.id, nbOverItems)
        currentItemTrial.quantity = currentItemTrial.quantity - nbOverItems
    end

    player:setLocalVar('storeTrialId', currentTrialId)
    player:setLocalVar('storeItemId', currentItem.id)
    player:setLocalVar('storeItemTrialId', currentItemTrial.id)
    player:setLocalVar('storeItemTrialQty', currentItemTrial.quantity)
    player:setLocalVar('storeNbTrialsPlayer', nbTrialsPlayer)

    player:tradeComplete()
    player:startEvent(10134, currentItemTrial.id, currentItemTrial.quantity, nbTrialsPlayer, currentTrialId, 0, 0, 0, 0)

    returnUselessItems(player, itemsTrial, currentItemTrial.id)
    returnUselessItems(player, items, currentItem.id)
end

xi.magian.deliveryCrateOnEventUpdate = function(player, csid, option, npc)
    local optionMod      = bit.band(option, 0xFF)
    local itemTrialId    = player:getLocalVar('storeItemTrialId')
    local nbTrialsPlayer = player:getLocalVar('storeNbTrialsPlayer')
    local maxNumber      = 31

    if csid == 10134 then
        if optionMod == 101 then
            player:updateEvent(itemTrialId, 0, 0, 0, 0, 0, maxNumber, 0)

        elseif optionMod == 103 then
            local places = bit.rshift(maxNumber, nbTrialsPlayer)
            local trials = getPlayerTrialByItemId(player, itemTrialId)
            local trialBits = getTrialsBits(player, trials)

            player:updateEvent(trialBits[1], trialBits[2], trialBits[3], trialBits[4], trialBits[5], nbTrialsPlayer, places, 0)
        end
    end
end

xi.magian.deliveryCrateOnEventFinish = function(player, csid, option, npc)
    local optionMod         = bit.band(option, 0xFF)
    local zoneid            = player:getZoneID()
    local msg               = zones[zoneid].text
    local trialId           = bit.rshift(option, 8)
    local itemTrialId       = player:getLocalVar('storeItemTrialId')
    local itemTrialQuantity = player:getLocalVar('storeItemTrialQty')
    local nbTrialsPlayer    = player:getLocalVar('storeNbTrialsPlayer')
    local itemId            = player:getLocalVar('storeItemId')

    if csid == 10134 then
        if optionMod == 0 then
            player:addItem(itemTrialId, itemTrialQuantity)
            player:messageSpecial(msg.RETURN_ITEM, itemTrialId)
        elseif optionMod == 102 then
            checkAndSetProgression(player, trialId, { itemId = itemTrialId, quantity = itemTrialQuantity }, xi.settings.main.MAGIAN_TRIALS_TRADE_MULTIPLIER)
        end

        if
            optionMod == 0 or
            optionMod == 102
        then
            if itemId ~= 0 and nbTrialsPlayer > 0 then
                local t = GetMagianTrial(trialId)
                player:addItem(t.reqItem, 1, t.reqItemAug1, t.reqItemAugValue1, t.reqItemAug2, t.reqItemAugValue2, t.reqItemAug3, t.reqItemAugValue3, t.reqItemAug4, t.reqItemAugValue4, trialId)
            end

            player:setLocalVar('storeTrialId', 0)
            player:setLocalVar('storeItemId', 0)
            player:setLocalVar('storeItemTrialId', 0)
            player:setLocalVar('storeItemTrialQty', 0)
            player:setLocalVar('storeNbTrialsPlayer', 0)
        end
    end
end

-- increments progress if conditions are met
xi.magian.checkMagianTrial = function(player, conditions)
    for _, slot in pairs({ xi.slot.MAIN, xi.slot.SUB, xi.slot.RANGED }) do
        local trialIdOnItem = player:getEquippedItem(slot) and player:getEquippedItem(slot):getTrialNumber()

        if trialIdOnItem ~= 0 then
            checkAndSetProgression(player, trialIdOnItem, conditions, xi.settings.main.MAGIAN_TRIALS_MOBKILL_MULTIPLIER)
        end
    end
end

-----------------------------------
-- Magian Orange / Blue
-----------------------------------
xi.magian.magianOnEventFinishOld = function(player, csid, option, EVENT_IDS)
    local optionMod = bit.band(option, 0xFF)
    local zoneid    = player:getZoneID()
    local msg       = zones[zoneid].text
    local ID        = zones[xi.zone.RULUDE_GARDENS]

    print(option)

    -- if option == 1073741824 then
    --     return
    -- end

    if
        csid == EVENT_IDS[2] and
        option == 1
    then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MAGIAN_TRIAL_LOG)
        player:addKeyItem(xi.ki.MAGIAN_TRIAL_LOG)

    -- starts a trial
    elseif
        csid == EVENT_IDS[4] and
        optionMod == 7
    then
        local trialId = bit.rshift(option, 8)
        local t       = GetMagianTrial(trialId)

        player:addItem(t.reqItem, 1, t.reqItemAug1, t.reqItemAugValue1, t.reqItemAug2, t.reqItemAugValue2, t.reqItemAug3, t.reqItemAugValue3, t.reqItemAug4, t.reqItemAugValue4, trialId)
        player:messageSpecial(msg.RETURN_MAGIAN_ITEM, t.reqItem)
        setTrial(player, firstEmptySlot(player), trialId, 0)
        player:setLocalVar('storeTrialId', 0)
        player:setLocalVar('storeItemId', 0)

    -- returns item to player
    elseif
        csid == EVENT_IDS[5] and
        (optionMod == 0 or optionMod == 4)
    then
        local trialId = player:getLocalVar('storeTrialId')
        local t       = GetMagianTrial(trialId)

        player:addItem(t.reqItem, 1, t.reqItemAug1, t.reqItemAugValue1, t.reqItemAug2, t.reqItemAugValue2, t.reqItemAug3, t.reqItemAugValue3, t.reqItemAug4, t.reqItemAugValue4, trialId)
        player:messageSpecial(msg.RETURN_MAGIAN_ITEM, t.reqItem)
        player:setLocalVar('storeTrialId', 0)

    elseif
        csid == EVENT_IDS[4] and
        (optionMod == 0 or option == utils.MAX_UINT32)
    then
        local trialId = player:getLocalVar('storeTrialId')
        local itemId  = player:getLocalVar('storeItemId')
        local t       = GetMagianTrial(trialId)

        if player:getLocalVar('invalidItem') ~= 1 then
            player:addItem(t.reqItem, 1, t.reqItemAug1, t.reqItemAugValue1, t.reqItemAug2, t.reqItemAugValue2, t.reqItemAug3, t.reqItemAugValue3, t.reqItemAug4, t.reqItemAugValue4, trialId)
        end

        player:messageSpecial(msg.RETURN_MAGIAN_ITEM, itemId)
        player:setLocalVar('invalidItem', 0)
        player:setLocalVar('storeTrialId', 0)
        player:setLocalVar('storeItemId', 0)

    -- gives back item after removing trial id
    elseif
        csid == EVENT_IDS[5] and
        (optionMod == 8 or optionMod == 11)
    then
        local trialId = bit.rshift(option, 8)
        local t       = GetMagianTrial(trialId)

        for i = 1, 10 do
            local tr, _, _ = getPlayerTrialByIndex(player, i)
            if tr == trialId then
                setTrial(player, i, 0, 0)
                break
            end
        end

        player:addItem(t.reqItem, 1, t.reqItemAug1, t.reqItemAugValue1, t.reqItemAug2, t.reqItemAugValue2, t.reqItemAug3, t.reqItemAugValue3, t.reqItemAug4, t.reqItemAugValue4, 0)
        player:messageSpecial(msg.RETURN_MAGIAN_ITEM, t.reqItem)

    -- finishes a trial
    elseif
        csid == EVENT_IDS[6] and
        optionMod == 0
    then
        local trialId = player:getLocalVar('storeTrialId')
        local slot    = hasTrial(player, trialId)

        if slot then
            setTrial(player, slot, 0, 0)
        end

        local t = GetMagianTrial(trialId)
        player:addItem(t.rewardItem, 1, t.rewardItemAug1, t.rewardItemAugValue1, t.rewardItemAug2, t.rewardItemAugValue2, t.rewardItemAug3, t.rewardItemAugValue3, t.rewardItemAug4, t.rewardItemAugValue4)
        player:messageSpecial(msg.ITEM_OBTAINED, t.rewardItem)
        player:setLocalVar('storeTrialId', 0)
    end
end
