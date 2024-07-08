-----------------------------------
-- func: addfish <fishId> <length> <weight>
-- desc: Adds a measured fish to the GMs inventory.
-----------------------------------
require('scripts/globals/fishing_contest')
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 3,
    parameters = 'siii'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!addfish <fish> <length> <weight> <optional:ranked>')
end

commandObj.onTrigger = function(player, item, length, weight, ranked)
    -- Load needed text ids for players current zone..
    local ID = zones[player:getZoneID()]
    local itemToGet = 0
    ranked = ranked and 1 or 0

    -- validate item
    if item == nil then
        -- No Item Provided
        error(player, 'No Item ID given.')
        return
    elseif item ~= nil and tonumber(item) == nil then
        -- Item was provided, but was not a number.  Try text lookup.
        local retItems = utils.filterArray(xi.fishingContest.fish, function(_, fish)
            return fish.name == item
        end)

        if #retItems ~= 1 then
            player:printToPlayer(string.format('Item %s not found in fish table.', item))
            return
        end

        itemToGet = retItems[1].id
    elseif tonumber(item) ~= nil then
        -- Number was provided, so just use it
        itemToGet = item
    end

    -- At this point, if there's no item found, exit out of the function
    if itemToGet == 0 then
        error(player, 'Item not found.')
        return
    end

    -- Confirm the size/weight
    if
        length == 0 or
        length == nil or
        weight == 0 or
        weight == nil
    then
        error(player, 'Size/Weight not provided.')
        return
    end

    -- Ensure the GM has room to obtain the item...
    if player:getFreeSlotsCount() < 1 then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemToGet)
        return
    end

    -- Give the GM the item...
    local obtained = player:addItem({ id = itemToGet,
                                    quantity = 1,
                                    exdata = xi.fishingContest.createExData(length, weight, ranked) })
    if obtained then
        player:messageSpecial(ID.text.ITEM_OBTAINED, itemToGet)
    end
end

return commandObj
