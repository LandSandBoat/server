---------------------------------------------------------------------------------------------------
-- func: spin <player>
-- desc: Spins a character in place. Used for fishbot detection. Changes player direction
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!spin <player> {angle}")
end

function onTrigger(player, target, angle)
    -- validate target
    if (target == nil) then
        error(player, "You must enter a target player name.")
        return
    end
    local targ = GetPlayerByName( target )
    if (targ == nil) then
        if not player:bringPlayer( target ) then
            error(player, string.format( "Player named '%s' not found!", target ) )
        end
        return
    end

	if (angle == nil) then
		angle = 128
    end
	if ((angle < 0) or (angle > 255)) then
		error(player, "Angle must be between 0 and 255")
		return
	end

    -- spin target
	local oldRot = targ:getRotPos()
	local newRot = oldRot + angle
	if (newRot > 255) then
		newRot = newRot - 255
	end
    targ:setPos( targ:getXPos(), targ:getYPos(), targ:getZPos(), newRot )
end
