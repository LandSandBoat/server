-----------------------------------
-- func: adddynatime
-- desc: Adds an amount of time to the given dynamis instance.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!adddynatime <zoneName> <minutes>")
end

function onTrigger(player, zoneName, minutes)
end