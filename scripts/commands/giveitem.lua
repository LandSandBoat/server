-----------------------------------
-- func: giveitem <player> <itemId> <amount> <aug1> <v1> <aug2> <v2> <aug3> <v3> <aug4> <v4>
-- desc: Gives an item to the target player.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'siiiiiiiiii'
}

commandObj.onTrigger = function(player, target, itemId, amount, aug0, aug0val, aug1, aug1val, aug2, aug2val, aug3, aug3val)
    if target == nil or itemId == nil then
        player:printToPlayer('You must enter a valid player name and item ID.')
        return
    end

    local targ = GetPlayerByName(target)
    if targ == nil then
        player:printToPlayer(string.format('Player named "%s" not found!', target))
        return
    end

    -- Load needed text ids for target's current zone..
    local ID = zones[targ:getZoneID()]

    -- Attempt to give the target the item..
    if targ:getFreeSlotsCount() == 0 then
        targ:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemId)
        player:printToPlayer(string.format('Player \'%s\' does not have free space for that item!', target))
    else
        local itemData =
        {
            id       = itemId,
            quantity = amount,
        }

        local hasExdata = false
        local augments  = {}
        local augmentPairs =
        {
            { aug0, aug0val },
            { aug1, aug1val },
            { aug2, aug2val },
            { aug3, aug3val },
        }

        for _, augmentData in ipairs(augmentPairs) do
            local augmentId = augmentData[1]
            if augmentId ~= nil and augmentId > 0 then
                hasExdata = true
                table.insert(augments, { id = augmentId, value = augmentData[2] or 0 })
            end
        end

        if hasExdata then
            itemData.exdata =
            {
                augmentKind    = xi.augment.kind.HAS_AUGMENTS,
                augmentSubKind = xi.augment.subKind.STANDARD,
                augments       = augments,
            }
        end

        targ:addItem(itemData)
        if amount and amount > 1 then
            targ:messageSpecial(ID.text.ITEM_OBTAINED + 9, itemId, amount)
        else
            targ:messageSpecial(ID.text.ITEM_OBTAINED, itemId)
        end

        player:printToPlayer(string.format('Gave player \'%s\' Item with ID of \'%u\'', target, itemId))
    end
end

return commandObj
