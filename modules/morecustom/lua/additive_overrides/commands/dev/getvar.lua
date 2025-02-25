-----------------------------------
-- func: !getvar
-- desc: Prints player's var value
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = "s"
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer("!getvar (var)")
end

commandObj.onTrigger = function(player, varName)
    local result = player:getCharVar(varName)
    player:printToPlayer(string.format("%s's var %s is %i.", player:getName(), varName, result), xi.msg.channel.SYSTEM_3)
end

return commandObj
