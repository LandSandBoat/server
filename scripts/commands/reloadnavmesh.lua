-----------------------------------
-- func: reloadnavmesh
-- desc: Reload the navmesh for the current zone
-- note: This is for reloading the underlying navmesh object, is not intended
--       to do anything to runtime pathing
-----------------------------------

cmdprops =
{
    permission = 5,
    parameters = ""
}

function onTrigger(player)
    local zone = player:getZone()
    player:PrintToPlayer("Reloading Navmesh for " .. zone:getName())
    zone:reloadNavmesh()
end
