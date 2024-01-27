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
    player:printToPlayer(msg)
    player:printToPlayer('!speed <0-255>')
end

commandObj.onTrigger = function(player, speed)
    if not speed then
        player:printToPlayer(string.format('Current Speed: %u', player:getSpeed()))

        return
    end

    -- Validate speed amount
    if speed < 0 or speed > 255 then
        error(player, 'Invalid speed amount.')

        return
    end

    -- Bypass speed and inform player.
    local baseSpeed = speed

    if speed == 0 then
        if player:hasStatusEffect(xi.effect.MOUNTED) then
            baseSpeed = 40 + xi.settings.map.MOUNT_SPEED_MOD
        else
            baseSpeed = 50 + xi.settings.map.SPEED_MOD
        end

        player:printToPlayer('Returning to your regular speed.')
    else
        player:printToPlayer('Bypassing regular speed calculations and limits.')
        player:printToPlayer('Set speed value to "0" to return to your regular speed.')
        player:printToPlayer(string.format('New speed: %u', speed))
    end

    player:setMod(xi.mod.MOVE_SPEED_OVERIDE, speed)
    player:setSpeed(baseSpeed)
end

return commandObj
