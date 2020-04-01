---------------------------------------------------------------------------------------------------
-- func: speed
-- desc: Sets the players movement speed.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!speed <0-255>")
end

function onTrigger(player, speed)

    -- validate speed amount
    if (speed == nil or speed < 0 or speed > 255) then
        error(player, "Invalid speed amount.")
        return
    end

    -- set speed
    player:speed( speed )

end
