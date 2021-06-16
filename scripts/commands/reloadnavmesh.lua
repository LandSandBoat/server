-----------------------------------
-- func: reloadnavmesh
-- desc: Reload the navmesh for the current zone
-- note: This is for reloading the underlying navmesh object, is not intended
--       to do anything to runtime pathing
-----------------------------------

function onTrigger(player)
    player:getZone():reloadNavmesh()
end
