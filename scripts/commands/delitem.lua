---------------------------------------------------------------------------------------------------
-- func: delitem
-- desc: Deletes a single item held by a player, if they have it.
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!delitem <itemID> {player}")
end

function onTrigger(player, itemId, target)

    -- validate itemId
    if (itemId == nil or itemId < 1) then
        error(player, "Invalid itemID.")
        return
    end

    -- validate target
    local targ
    if (target == nil) then
        targ = player
    else
        targ = GetPlayerByName(target)
        if (targ == nil) then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    -- search target inventory for item, and delete if found
    for i = tpz.inv.INVENTORY, tpz.inv.WARDROBE4 do -- inventory locations enums
        if (targ:hasItem(itemId, i)) then
            targ:delItem(itemId, 1, i)
            player:PrintToPlayer(string.format("Item %i was deleted from %s.", itemId, targ:getName()))
            break
        end
        if (i == tpz.inv.WARDROBE4) then -- Wardrobe 4 is the last inventory location, if it reaches this point then the player does not have the item anywhere.
            player:PrintToPlayer(string.format("%s does not have item %i.", targ:getName(), itemId))
        end
    end

end
