-----------------------------------
-- func: setbattlefieldtime
-- desc: Set time limit for an active battlefield
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 4,
    parameters = 'i'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!setbattlefieldtime <minutes>')
end

commandObj.onTrigger = function(player, minutes)
    local battlefield = player:getBattlefield()
    if not battlefield then
        error(player, 'This command can only be used while inside a battlefield.')
        return
    end

    battlefield:setTimeLimit(minutes * 60)
end

return commandObj
