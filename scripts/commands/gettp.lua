-----------------------------------
-- func: gettp
-- desc: prints tp of the player and the target(if applicable), for debugging.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

commandObj.onTrigger = function(player, option)
    local target = player:getCursorTarget() or player

    local targetType = target:getObjType()

    if targetType == xi.objType.NPC then
        player:printToPlayer('Target something other than an NPC')
        return
    end

    if target == player then
        player:printToPlayer(string.format('Player TP: %i', player:getTP()), xi.msg.channel.SYSTEM_3)
        return
    else
        player:printToPlayer(string.format('Player TP: %i', player:getTP()), xi.msg.channel.SYSTEM_3)
        player:printToPlayer(string.format('Target TP: %i', target:getTP()), xi.msg.channel.SYSTEM_3)
    end
end

return commandObj
