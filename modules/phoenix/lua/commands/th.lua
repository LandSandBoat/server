-----------------------------------
-- func: TH
-- desc: Shows the target mob's current Treasure Hunter level.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = '',
}

commandObj.onTrigger = function(player)
    local target = player:getCursorTarget()

    if
        not target or
        target:getObjType() ~= xi.objType.MOB or
        not target:isAlive()
    then
        player:printToPlayer('Target a living mob to check its Treasure Hunter level.', xi.msg.channel.SYSTEM_3)
        return
    end

    player:printToPlayer(target:getName() .. ': Treasure Hunter ' .. tostring(target:getTHlevel()), xi.msg.channel.SYSTEM_3)
end

xi.module.registerCommand('TH', commandObj)
xi.module.registerCommand('th', commandObj)
