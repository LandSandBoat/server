-----------------------------------
-- func: resetdynaplayer
-- desc: Resets an instance of Dynamis
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!resetdyna <playerName>")
end

function onTrigger(player, playerName)
    local targ
    if not playerName or playerName == "" then
        targ = player:getCursorTarget()
    else
        targ = GetPlayerByName(playerName)
    end

    if not targ or not targ:isPC() then
        error(player, string.format("Failed to find player by name '%s'", playerName))
        return
    end

    targ:setCharVar("DynaReservationStart", 73)
    player:PrintToPlayer(string.format("[ResetDynaPlayer] Reset reservation for player '%s'", targ:getName()))
end
