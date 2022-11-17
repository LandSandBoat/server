---------------------------------------------------------------------------------------------------
-- func: stopgarrison
-- desc: stops the garrison (if any) currently running in the player's zone
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    xi.garrison.stop(player:getZone())
    player:PrintToPlayer("Garrison event stopped")
end
