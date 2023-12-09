-----------------------------------
-- func: addallmounts
-- desc: Adds all mount key items to player, granting access to their associated mounts
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!addallmounts (player)')
end

commandObj.onTrigger = function(player, target)
    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    -- add all mount key items
    for i = xi.ki.CHOCOBO_COMPANION, xi.ki.CHOCOBO_COMPANION + 26 do
        targ:addKeyItem(i)
    end

    player:printToPlayer(string.format('%s now has all mounts.', targ:getName()))
end

return commandObj
