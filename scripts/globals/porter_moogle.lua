-----------------------------------
-- Porter Moogle Utilities
-- desc: Common functionality for Porter Moogles.
-----------------------------------
local slipItems = require('scripts/globals/porter_slip_items')
-----------------------------------
xi = xi or {}
xi.porter_moogle = xi.porter_moogle or {}

-- Item IDs for all of the slips.
local slipIds =
{
    xi.item.MOOGLE_STORAGE_SLIP_01,
    xi.item.MOOGLE_STORAGE_SLIP_02,
    xi.item.MOOGLE_STORAGE_SLIP_03,
    xi.item.MOOGLE_STORAGE_SLIP_04,
    xi.item.MOOGLE_STORAGE_SLIP_05,
    xi.item.MOOGLE_STORAGE_SLIP_06,
    xi.item.MOOGLE_STORAGE_SLIP_07,
    xi.item.MOOGLE_STORAGE_SLIP_08,
    xi.item.MOOGLE_STORAGE_SLIP_09,
    xi.item.MOOGLE_STORAGE_SLIP_10,
    xi.item.MOOGLE_STORAGE_SLIP_11,
    xi.item.MOOGLE_STORAGE_SLIP_12,
    xi.item.MOOGLE_STORAGE_SLIP_13,
    xi.item.MOOGLE_STORAGE_SLIP_14,
    xi.item.MOOGLE_STORAGE_SLIP_15,
    xi.item.MOOGLE_STORAGE_SLIP_16,
    xi.item.MOOGLE_STORAGE_SLIP_17,
    xi.item.MOOGLE_STORAGE_SLIP_18,
    xi.item.MOOGLE_STORAGE_SLIP_19,
    xi.item.MOOGLE_STORAGE_SLIP_20,
    xi.item.MOOGLE_STORAGE_SLIP_21,
    xi.item.MOOGLE_STORAGE_SLIP_22,
    xi.item.MOOGLE_STORAGE_SLIP_23,
    xi.item.MOOGLE_STORAGE_SLIP_24,
    xi.item.MOOGLE_STORAGE_SLIP_25,
    xi.item.MOOGLE_STORAGE_SLIP_26,
    xi.item.MOOGLE_STORAGE_SLIP_27,
    xi.item.MOOGLE_STORAGE_SLIP_28,
}

-----------------------------------
-- desc : Checks if the supplied item is a Moogle Storage Slip.
-----------------------------------
local function isSlip(itemId)
    return slipItems[itemId] ~= nil
end

-----------------------------------
-- desc : Checks if the supplied slip can store the supplied item.
-----------------------------------
local function isStorableOn(slipId, itemId)
    for _, id in ipairs(slipItems[slipId]) do
        if id == itemId then
            return true
        end
    end

    return false
end

-----------------------------------
-- desc : Gets IDs of retrievable items from the extra data on a slip.
-----------------------------------
local function getItemsOnSlip(extra, slipId)
    local slip = slipItems[slipId]
    local itemsOnSlip = {}
    local x = 1

    for k, v in ipairs(slip) do
        local byte = extra[math.floor((k - 1) / 8) + 1]

        if byte < 0 then
            byte = byte + 256
        end

        if bit.band(bit.rshift(byte, (k - 1) % 8), 1) ~= 0 then
            itemsOnSlip[x] = v
            x = x + 1
        end
    end

    return itemsOnSlip
end

-----------------------------------
-- desc : Finds the key in table t where the value equals i.
-----------------------------------
local function find(t, i)
    for k, v in ipairs(t) do
        if v == i then
            return k
        end
    end

    return nil
end

-----------------------------------
-- desc : Converts the 8 bit extra data into 32 bit params for events.
-----------------------------------
local function int8ToInt32(extra)
    local params = {}
    local int32 = ''

    for k, v in ipairs(extra) do
        int32 = string.format('%02x%s', v, int32)
        if k % 4 == 0 then
            params[#params + 1] = tonumber(int32, 16)
            int32 = ''
        end
    end

    if int32 ~= '' then
        params[#params + 1] = tonumber(int32, 16)
    end

    return params
end

-----------------------------------
-- desc : Gets Storage Slip ID from the trade window (does nothing
--        if there are two or more Storage Slips in the trade and no
--        storable items.
-----------------------------------
local function getSlipId(trade)
    local slipId = 0
    local slips = 0

    for _, itemId in ipairs(slipIds) do
        if trade:hasItemQty(itemId, 1) then
            slips = slips + 1

            if slipId == 0 then
                slipId = itemId
            end
        end
    end

    if slips == trade:getItemCount() and slips > 1 then
        slipId = 0
    end

    return slipId, slips
end

-----------------------------------
-- desc : Gets all items in the trade window that are storable on the
--        slip in the trade window.
-----------------------------------
local function getStorableItems(player, trade, slipId)
    local storableItemIds = { }

    for i = 0, 7 do
        local slotItemId = trade:getItemId(i)

        if
            slotItemId ~= 0 and
            not isSlip(slotItemId) and
            player:hasItem(slotItemId)
        then
            if isStorableOn(slipId, slotItemId) then
                storableItemIds[#storableItemIds + 1] = slotItemId
            end
        end
    end

    return storableItemIds
end

-----------------------------------
-- desc : Stores the items on the Storage Slip extra data and starts
--        the event indicating that the storage was successful.
-----------------------------------
local function storeItems(player, storableItemIds, slipId, eventTable)
    if #storableItemIds > 0 then
        local param0 = #storableItemIds
        local param1 = 1

        if #storableItemIds == 1 then
            param0 = storableItemIds[1]
            param1 = 0
        end

        local extra = { }

        for i = 0, 23 do
            extra[i] = 0
        end

        for k, v in ipairs(slipItems[slipId]) do
            if find(storableItemIds, v) ~= nil then
                local bitmask = extra[math.floor((k - 1) / 8)]

                if bitmask < 0 then
                    bitmask = bitmask + 256
                end

                extra[math.floor((k - 1) / 8)] = bit.bor(bitmask, bit.lshift(1, (k - 1) % 8))
            end
        end

        local result = player:storeWithPorterMoogle(slipId, extra, storableItemIds)

        if result == 0 then
            player:startEvent(eventTable.STORE_EVENT_ID, param0, param1)
        elseif result == 1 then
            player:startEvent(eventTable.ALREADY_STORED_ID)
        elseif result == 2 then
            player:startEvent(eventTable.MAGIAN_TRIAL_ID)
        end
    end
end

-----------------------------------
-- desc : Returns a zero-based identifier for the slip (Storage Slip 1
--        is index 0, Storage Slip 2 is index 1, etc).
-----------------------------------
local function getSlipIndex(slipId)
    return find(slipIds, slipId) - 1
end

-----------------------------------
-- desc : Gets the extra data from the traded slip and starts the
--        retrieval event.
-----------------------------------
local function startRetrieveProcess(player, eventId, slipId)
    local extra = player:getRetrievableItemsForSlip(slipId)
    local params = int8ToInt32(extra)
    local slipIndex = getSlipIndex(slipId)

    player:setLocalVar('slipId', slipId)
    player:startEvent(eventId, params[1], params[2], params[3], params[4], params[5], params[6], nil, slipIndex)
end

-----------------------------------
-- desc : Begins the storage or retrieval process based on the items
--        supplied in the trade.
-----------------------------------
xi.porter_moogle.onTrade = function(player, trade, eventTable)
    local slipId, slipCount = getSlipId(trade)

    if slipId == 0 or slipCount > 1 then
        return
    end

    local storableItemIds = getStorableItems(player, trade, slipId)

    if #storableItemIds > 0 then
        storeItems(player, storableItemIds, slipId, eventTable)
    else
        startRetrieveProcess(player, eventTable.RETRIEVE_EVENT_ID, slipId)
    end
end

-----------------------------------
-- desc : Retrieves the selected item from storage, removes it from
--        the slip's extra data, displays a message to the user, and
--        updates the user's event data.
-----------------------------------
xi.porter_moogle.onEventUpdate = function(player, csid, option, retrieveEventId)
    local slipId = player:getLocalVar('slipId')

    if csid == retrieveEventId and slipId ~= 0 and slipId ~= nil then
        local extra = player:getRetrievableItemsForSlip(slipId)
        local itemsOnSlip = getItemsOnSlip(extra, slipId)
        local retrievedItemId = itemsOnSlip[option + 1]

        if player:hasItem(retrievedItemId) or player:getFreeSlotsCount() == 0 then
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, retrievedItemId)
        else
            local k = find(slipItems[slipId], retrievedItemId)
            local extraId = math.floor((k - 1) / 8)
            local bitmask = extra[extraId + 1]

            if bitmask < 0 then
                bitmask = bitmask + 256
            end

            bitmask = bit.band(bitmask, bit.bnot(bit.lshift(1, (k - 1) % 8)))
            extra[extraId + 1] = bitmask

            player:retrieveItemFromSlip(slipId, retrievedItemId, extraId, bitmask)
            player:messageSpecial(zones[player:getZoneID()].text.RETRIEVE_DIALOG_ID, retrievedItemId, nil, nil, retrievedItemId, false)
        end

        local params = int8ToInt32(extra)
        player:updateEvent(params[1], params[2], params[3], params[4], params[5], params[6], slipId)
    end
end

-----------------------------------
-- desc : Completes the event.
-----------------------------------
xi.porter_moogle.onEventFinish = function(player, csid, option, talkEventId)
    if csid == talkEventId and option < 1000 then
        option = math.floor(option / 16) + (option % 16)

        local hasItem = player:hasItem(slipIds[option])

        if hasItem or player:getFreeSlotsCount() == 0 then
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, slipIds[option])
            return
        end

        if player:delGil(1000) then
            player:addItem(slipIds[option])
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, slipIds[option])
        else
            player:messageSpecial(zones[player:getZoneID()].text.NOT_HAVE_ENOUGH_GIL, slipIds[option])
            return
        end
    else
        player:setLocalVar('slipId', 0)
    end
end
