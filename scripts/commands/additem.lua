-----------------------------------
-- func: additem <itemId> <quantity> <aug1> <v1> <aug2> <v2> <aug3> <v3> <aug4> <v4> <trial>
-- desc: Adds an item to the GMs inventory.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'siiiiiiiiii'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!additem <itemId> (quantity) (aug1) (v1) (aug2) (v2) (aug3) (v3) (aug4) (v4) (trial)')
end

commandObj.onTrigger = function(player, item, quantity, aug0, aug0val, aug1, aug1val, aug2, aug2val, aug3, aug3val, trialId)
    -- Load needed text ids for players current zone..
    local ID = zones[player:getZoneID()]
    local itemToGet = 0

    -- validate item
    if item == nil then
        -- No Item Provided
        error(player, 'No Item ID given.')
        return
    elseif tonumber(item) == nil and item ~= nil then
        -- Item was provided, but was not a number.  Try text lookup.
        local retItem = GetItemIDByName(tostring(item))
        if retItem > 0 and retItem < 65000 then
            itemToGet = retItem
        elseif retItem >= 65000 then
            player:printToPlayer(string.format('Found %s instances matching "%s".  Use ID or exact name.', 65536 - retItem,  tostring(item)))
            return
        else
            player:printToPlayer(string.format('Item %s not found in database.', item))
            return
        end
    else
        -- Number was provided, so just use it
        itemToGet = tonumber(item)
    end

    -- if quantity is nil, assume 1 qty
    quantity = quantity or 1

    -- At this point, if there's no item found, exit out of the function
    if itemToGet == 0 then
        error(player, 'Item not found.')
        return
    end

    -- TODO: check qty and stack size + remaining inventory space instead of hardcoded == 0 check
    -- Ensure the GM has room to obtain the item...
    if player:getFreeSlotsCount() == 0 then
        if quantity > 1 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED + 1, itemToGet)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemToGet)
        end

        return
    end

    -- Give the GM the item...
    local obtained = player:addItem(itemToGet, quantity, aug0, aug0val, aug1, aug1val, aug2, aug2val, aug3, aug3val, trialId)
    if obtained then
        if quantity and quantity > 1 then
            player:messageSpecial(ID.text.ITEM_OBTAINED + 9, itemToGet, quantity)
        else
            player:messageSpecial(ID.text.ITEM_OBTAINED, itemToGet)
        end
    end
end

return commandObj
