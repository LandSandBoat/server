-----------------------------------
-- func: reloaddefaultactions
-- desc: Reloads default actions for current zone or all
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 5,
    parameters = 'b'
}

commandObj.onTrigger = function(player, allZones)
    if allZones then
        InteractionGlobal.loadDefaultActions(true)
        player:PrintToPlayer('Default actions have been reloaded for all zones.')
    else
        InteractionGlobal.loadDefaultActionsForZone(player:getZoneID(), true)
        player:PrintToPlayer('Default actions have been reloaded for this zone.')
    end
end

return commandObj
