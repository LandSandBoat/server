---------------------------------------------------------------------------------------------------
-- func: giveitem <player> <itemId> <amount> <aug1> <v1> <aug2> <v2> <aug3> <v3> <aug4> <v4>
-- desc: Gives an item to the target player.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "siiiiiiiiii"
}

function onTrigger(player, target, itemId, amount, aug0, aug0val, aug1, aug1val, aug2, aug2val, aug3, aug3val)
    if (target == nil or itemId == nil) then
        player:PrintToPlayer("You must enter a valid player name and item ID.")
        return
    end

    local targ = GetPlayerByName( target )
    if (targ == nil) then
        player:PrintToPlayer( string.format( "Player named '%s' not found!", target ) )
        return
    end

    -- Load needed text ids for target's current zone..
    local ID = zones[targ:getZoneID()]

    -- Attempt to give the target the item..
    if (targ:getFreeSlotsCount() == 0) then
        targ:messageSpecial( ID.text.ITEM_CANNOT_BE_OBTAINED, itemId )
        player:PrintToPlayer( string.format( "Player '%s' does not have free space for that item!", target ) )
    else
        targ:addItem( itemId, amount, aug0, aug0val, aug1, aug1val, aug2, aug2val, aug3, aug3val )
        targ:messageSpecial( ID.text.ITEM_OBTAINED, itemId )
        player:PrintToPlayer( string.format( "Gave player '%s' Item with ID of '%u' ", target, itemId ) )
    end
end
