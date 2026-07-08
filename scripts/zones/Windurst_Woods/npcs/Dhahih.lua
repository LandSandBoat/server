-----------------------------------
-- Area: Windurst Woods
--  NPC: Dhahih
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 6.110, y = 0.000, z = 122.311, wait = 8000 },
    { x = 15.913, z = 111.901 },
    { x = 20.867, z = 106.642, wait = 8000 },
    { x = 15.913, z = 111.901 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
