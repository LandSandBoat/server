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

commandObj.onTrigger = function(player, itemId, length, weight, ranked)
    -- Load needed text ids for players current zone..
    local ID = zones[player:getZoneID()]
    local itemToGet = 0
    ranked = ranked and 1 or 0

    -- validate item
    if itemId == nil then
        -- No Item Provided
        error(player, 'No Item ID given.')
        return
    elseif itemId ~= nil and tonumber(itemId) == nil then
        -- Item was provided, but was not a number.  Try text lookup.
        local retItems = utils.filterArray(xi.fishingContest.fish, function(_, fish)
            return fish.name == itemId
        end)

        if #retItems ~= 1 then
            player:printToPlayer(string.format('Item %s not found in fish table.', itemId))
            return
        end

        itemToGet = retItems[1].id
    elseif tonumber(itemId) ~= nil then
        -- Number was provided, so just use it
        itemToGet = itemId
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

    -- Give the GM the item and set exdata...
    local item = player:addItem({ id = itemToGet, quantity = 1 })
    if item then
        item:setExData({
            size     = length,
            weight   = weight,
            isRanked = ranked == 1,
        })
        player:messageSpecial(ID.text.ITEM_OBTAINED, itemToGet)
    end
end

return commandObj
