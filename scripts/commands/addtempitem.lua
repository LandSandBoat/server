-----------------------------------
-- func: addtempitem
-- desc: Adds a temp item to the players inventory.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "ii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!addtempitem <itemID> <quantity>")
end

function onTrigger(player, itemId, quantity)
    -- validate itemId
    if (itemId ~= nil) then
        itemId = tonumber(itemId)
    end
    if (itemId == nil or itemId == 0) then
        error(player, "Invalid itemID.")
        return
    end

    -- validate quantity
    quantity = tonumber(quantity) or 1
    if (quantity == nil or quantity < 1) then
        error(player, "Invalid quantity.")
        return
    end

    -- add temp item
    player:addTempItem(itemId, quantity, 0, 0, 0, 0, 0, 0, 0, 0)
end
