-----------------------------------
-- func: spin (degrees) (player)
-- desc: Rotates the cursor target or named player in place. Defaults to 180 degrees.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'ss'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!spin (degrees) (player)')
end

local function resolveTarget(player, name)
    if name ~= nil then
        return GetPlayerByName(name)
    end

    local cursorTarget = player:getCursorTarget()
    if
        cursorTarget ~= nil and
        cursorTarget:isPC()
    then
        return cursorTarget
    end

    return nil
end

commandObj.onTrigger = function(player, arg1, arg2)
    -- Degrees are optional, so a lone non-numeric argument is the player name
    local degrees = tonumber(arg1)
    local name    = arg2
    if degrees == nil then
        degrees = 180
        name    = arg1
    end

    local target = resolveTarget(player, name)
    if target == nil then
        error(player, 'You must target a player or specify the name of an online player.')
        return
    end

    local rotation = (target:getRotPos() + math.floor(degrees * 256 / 360 + 0.5)) % 256

    -- setPos pushes the new heading to the client; setRotation alone only updates onlookers
    target:setPos(target:getXPos(), target:getYPos(), target:getZPos(), rotation)
    player:printToPlayer(string.format('Rotated %s by %g degrees.', target:getName(), degrees), xi.msg.channel.SYSTEM_3)
end

xi.module.registerCommand('spin', commandObj)
