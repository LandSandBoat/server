-----------------------------------
-- func: delallinventory
-- desc: Deletes all items in a player's inventory, if they have any.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!delallinventory (player)')
end

commandObj.onTrigger = function(player, target)
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
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    if targ:delContainerItems(xi.inv.INVENTORY) then
        player:printToPlayer(string.format('Deleted entire inventory for %s.', targ:getName()))
    end
end

return commandObj
