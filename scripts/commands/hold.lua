---------------------------------------------------------------------------------------------------
--func: !hold <t>
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = "s"
}

function onTrigger(player, target)

    if (target == nil) then
        player:PrintToPlayer("You must enter a valid target name.")
        player:PrintToPlayer( "!hold <player>" )

        return
    end

    local targ = GetPlayerByName(target)
    if (targ ~= nil) then
		if (targ:getStatusEffect(28)) then
			targ:addStatusEffect(28, 9999, 9999, 0)
		else
			targ:addStatusEffect(28, 9999, 9999, 999999)
			targ:PrintToPlayer("You cant move.")
		end
	end
end
