-----------------------------------
-- func: additem <itemId> <quantity> <aug1> <v1> <aug2> <v2> <aug3> <v3> <aug4> <v4> <trial>
-- desc: Adds an item to the GMs inventory.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "siiiiiiiiii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!additem <item> {quantity} {aug1} {v1} {aug2} {v2} {aug3} {v3} {aug4} {v4} {trial}")
end

function onTrigger(player, item, quantity, aug0, aug0val, aug1, aug1val, aug2, aug2val, aug3, aug3val, trialId)
    -- Load needed text ids for players current zone..
    local ID = zones[player:getZoneID()]
    local itemToGet = 0

    -- validate item
    if item == nil then
        -- No Item Provided
        error(player, "No Item ID given.")
        return
    elseif tonumber(item) == nil and item ~= nil then
        -- Item was provided, but was not a number.  Try text lookup.
        local retItem = GetItemIDByName(tostring(item))
        if retItem > 0 and retItem < 65000 then
            itemToGet = retItem
        elseif retItem >= 65000 then
            player:PrintToPlayer(string.format("Found %s instances matching '%s'.  Use ID or exact name.", 65536 - retItem,  tostring(item)))
            return
        else
            player:PrintToPlayer(string.format("Item %s not found in database.", item))
            return
        end
    else
        -- Number was provided, so just use it
        itemToGet = tonumber(item)
    end

    -- At this point, if there's no item found, exit out of the function
    if itemToGet == 0 then
        error(player, "Item not found.")
        return
    end

    -- Ensure the GM has room to obtain the item...
    if player:getFreeSlotsCount() == 0 then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        return
    end

    -- Give the GM the item...
    player:addItem(itemToGet, quantity, aug0, aug0val, aug1, aug1val, aug2, aug2val, aug3, aug3val, trialId)
    if quantity and quantity > 1 then
        player:messageSpecial(ID.text.ITEM_OBTAINED + 9, itemToGet, quantity)
    else
        player:messageSpecial(ID.text.ITEM_OBTAINED, itemToGet)
    end
end