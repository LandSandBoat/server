-----------------------------------
-- Area: Windurst Woods
--  NPC: Dhahah
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 18.947, y = 0.000, z = 86.480 },
    { x = 16.665, z = 78.920 },
    { x = 12.472, z = 70.061 },
    { x = 16.665, z = 78.920 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
