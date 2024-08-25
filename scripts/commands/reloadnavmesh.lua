-----------------------------------
-- func: reloadnavmesh
-- desc: Reload the navmesh for the current zone
-- note: This is for reloading the underlying navmesh object, is not intended
--       to do anything to runtime pathing
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 5,
    parameters = ''
}

commandObj.onTrigger = function(player)
    local zone = player:getZone()
    if not zone then
        return
    end

    player:printToPlayer('Reloading Navmesh for ' .. zone:getName())
    zone:reloadNavmesh()
end

return commandObj
