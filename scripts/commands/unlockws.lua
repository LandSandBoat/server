-----------------------------------
-- func: addallweaponskills
-- desc: Adds all learned weaponskills to the given target. If no target then to the current player.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!unlocksweaponskill {id} {player}")
end

function onTrigger(player, wsId, target)

    -- validate target
    local targ
	local wsId
    player:PrintToPlayer(string.format("WS ID: %s", wsId))
	
--	wsId = tonumber(wsId) or xi.ws_unlock[string.upper(wsId)]
	if (wsId == nil) then
	    error(player, "You must supply a weaponskill id.")
		return
	end
    if target then
        targ = GetPlayerByName(target)
        if not targ then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    else
        targ = player
    end

    -- add all learned weaponskills
    targ:addLearnedWeaponskill(wsId)
    player:PrintToPlayer(string.format("%s has unlocked the weaponskill.", targ:getName()))
end
