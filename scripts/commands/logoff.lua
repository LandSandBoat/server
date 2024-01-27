-----------------------------------
-- func: logoff
-- desc: Logs the target player off by force.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!logoff (player)')
end

commandObj.onTrigger = function(player, target)
    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Invalid player \'%s\' given.', target))
            return
        end
    end

    -- logoff target
    targ:leaveGame()
    if targ:getID() ~= player:getID() then
        player:printToPlayer(string.format('%s has been logged off.', targ:getName()))
    end
end

return commandObj
