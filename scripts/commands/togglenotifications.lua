-----------------------------------
-- func: hideme
-- desc: controls whether a notification will be sent when a player comes online.
-----------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
}

function onTrigger(player)
    if player:getCharVar("NoOnlineNotification") ~= 1 then
	    player:setCharVar("NoOnlineNotification", 1)
		player:PrintToPlayer("The world will no longer be notified when you come online.")
	elseif player:getCharVar("NoOnlineNotification") == 1 then
	    player:setCharVar("NoOnlineNotification", 0)
		player:PrintToPlayer("A notification will be dispatched when you come online.")	
	end
end
