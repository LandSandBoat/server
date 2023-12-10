-----------------------------------
-- func: !instance <instance_id>
-- desc: Load an instance and take you there
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

local function error(player, msg)
    player:printToPlayer(msg .. '\n!instance <instance_id>')
end

commandObj.onTrigger = function(player, instance_id)
    if instance_id == nil then
        error(player, 'You must provide an instance id')
        return
    end

    local currentInstance = player:getInstance()
    if currentInstance then
        player:printToPlayer('It is not safe to use this command while inside an instance, try again after exiting.')
        currentInstance:fail()
    else
        player:printToPlayer('Creating instance: ' .. instance_id)
        player:createInstance(instance_id)
    end
end

return commandObj
