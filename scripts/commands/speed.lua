-----------------------------------
-- func: speed
-- desc: Sets the players movement speed.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!speed <0-255>')
end

commandObj.onTrigger = function(player, speed)
    if not speed then
        player:PrintToPlayer(string.format('Current Speed: %u', player:getSpeed()))
        player:PrintToPlayer(string.format('Current xi.mod.MOVE: %u', player:getMod(xi.mod.MOVE)))
        return
    end

    -- Validate speed amount
    if speed < 0 or speed > 255 then
        error(player, 'Invalid speed amount.')
        return
    end

    -- Inform player and set speed
    player:PrintToPlayer(string.format('Old Speed: %u', player:getSpeed()))
    player:PrintToPlayer(string.format('New Speed: %u', speed))
    player:setSpeed(speed)
end

return commandObj
