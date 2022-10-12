-----------------------------------
-- func: dawnunstuck
-- desc: Releases the player from stuck event at CoP 8-4 DAWN.
-----------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!release {name}")
end

function onTrigger(player)
    local target
    if name == nil then
        target = player
    else
        target = GetPlayerByName(name)
        if target == nil then
            error(player, string.format("Player named '%s' not found!", name))
            return
        end
    end

    if
	    target:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.DAWN and target:getZoneID() == 36
	then
	    target:PrintToPlayer("Attempting to unstuck you...")
        
		target:timer(2000, function(targetArg)
            target:setPos(target:getXPos(), target:getYPos(), target:getZPos(), target:getRotPos(), target:getZoneID())
        end)
    end
end
