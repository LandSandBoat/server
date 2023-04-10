-----------------------------------
-- func: hasitem
-- desc: Checks if a player has a specific item
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!hasitem <itemID> (player)")
end

function onTrigger(player, itemId, target)
    -- validate itemId
    if itemId == nil then
        error(player, "You must provide an itemID.")
        return
    elseif itemId < 1 then
        error(player, "Invalid itemID.")
        return
    end

    -- validate target
    local targ
    if target == nil then
        targ = player:getCursorTarget()
        if targ == nil or not targ:isPC() then
            targ = player
        end
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    -- report hasItem
    if targ:hasItem(itemId) then
        player:PrintToPlayer(string.format("%s has item %i.", targ:getName(), itemId))
    else
        player:PrintToPlayer(string.format("%s does not have item %i.", targ:getName(), itemId))
    end
end
