-----------------------------------
-- func: !setvar
-- desc: Sets player's var value
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = "si"
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer("!getvar (var) (value)")
end

commandObj.onTrigger = function(player, varName, varValue)
    local result = player:getCharVar(varName)
    player:setCharVar(varName, varValue)
    player:printToPlayer(string.format("%s's var %s has been updated from %i to %i.", player:getName(), varName, result, varValue), xi.msg.channel.SYSTEM_3)
end

return commandObj
