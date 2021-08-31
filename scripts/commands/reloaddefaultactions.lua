---------------------------------------------------------------------------------------------------
-- func: reloaddefaultactions
-- desc: Reloads default actions for current zone or all
---------------------------------------------------------------------------------------------------
require("scripts/globals/interaction/interaction_global")

cmdprops =
{
    permission = 5,
    parameters = "b"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!reloaddefaultactions <do-for-all-zones>")
end

function onTrigger(player, allZones)
    if allZones then
        InteractionGlobal.loadDefaultActions(true)
        player:PrintToPlayer("Default actions have been reloaded for all zones.")
    else
        InteractionGlobal.loadDefaultActionsForZone(player:getZoneID(), true)
        player:PrintToPlayer("Default actions have been reloaded for this zone.")
    end
end
