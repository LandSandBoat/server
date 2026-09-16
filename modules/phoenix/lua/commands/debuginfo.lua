-----------------------------------
-- func: debuginfo
-- desc: Prints zone, position, level, and target information for testing.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = '',
}

commandObj.onTrigger = function(player)
    local zone = player:getZone()

    if not zone then
        player:printToPlayer('Error: Unable to retrieve zone information.', xi.msg.channel.SYSTEM_3)
        return
    end

    player:printToPlayer(string.format('Zone: %s (%i)  Pos: X %.2f  Y %.2f  Z %.2f  Rot %i',
        zone:getName(), zone:getID(), player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos()),
        xi.msg.channel.SYSTEM_3)

    player:printToPlayer(string.format('Level: %i  Job: %i/%i  HP: %i/%i  MP: %i/%i',
        player:getMainLvl(), player:getMainJob(), player:getSubJob(),
        player:getHP(), player:getMaxHP(), player:getMP(), player:getMaxMP()),
        xi.msg.channel.SYSTEM_3)

    local target = player:getCursorTarget()
    if target ~= nil then
        player:printToPlayer(string.format('Target: %s  ID: %i  Pos: X %.2f  Y %.2f  Z %.2f',
            target:getName(), target:getID(), target:getXPos(), target:getYPos(), target:getZPos()),
            xi.msg.channel.SYSTEM_3)
    end
end

xi.module.registerCommand('debuginfo', commandObj)
