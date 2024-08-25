-----------------------------------
-- Func: getlocalvars
-- Desc: Gets all local vars of a target
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    local targ = player:getCursorTarget()
    if targ == nil then
        return
    end

    local vars = {}
    vars = targ:getLocalVars()

    if #vars > 0 then
        player:printToPlayer(string.format('Printing local vars for entity: %s', targ:getName()), xi.msg.channel.SYSTEM_3)
        player:printToPlayer('----------------------------------', xi.msg.channel.SYSTEM_3)
        for _, var in pairs(vars) do
            player:printToPlayer(string.format('"%s" : %u', var['varname'], var['value']), xi.msg.channel.SYSTEM_3)
        end
    else
        player:printToPlayer(string.format('No local vars for entity: %s', targ:getName()), xi.msg.channel.SYSTEM_3)
    end
end

return commandObj
