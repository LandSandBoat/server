-----------------------------------
-- func: speed
-- desc: Sets the players movement speed.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

commandObj.onTrigger = function(player, speed)
    if not speed then
        player:printToPlayer(string.format('Current Speed: %u', player:getSpeed()))

        return
    end

    -- Validate speed amount
    speed = utils.clamp(speed, -1, 255)

    if speed == 0 then
        player:printToPlayer('Returning to your regular speed.')
    else
        player:printToPlayer('Bypassing regular speed calculations and limits.')
        player:printToPlayer('Set speed value to "0" to return to your regular speed, any negative number to bind.')
        player:printToPlayer(string.format('New speed: %u', speed == -1 and 0 or speed))
    end

    player:setMod(xi.mod.MOVE_SPEED_OVERRIDE, speed)
    player:recalculateStats()
end

return commandObj
