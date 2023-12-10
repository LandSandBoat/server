-----------------------------------
-- func: addallmonstrosity
-- desc: Adds all species, instincts, and variants for monstrosity
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!addallmonstrosity (player)')
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

    xi.monstrosity.unlockAll(targ)

    player:printToPlayer(string.format('%s now has all monstrosity data.', targ:getName()))
end

return commandObj
