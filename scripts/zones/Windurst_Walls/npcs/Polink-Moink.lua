-----------------------------------
-- Area: Windurst Walls
--  NPC: Polink-Moink
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -3.473, y = -6.670, z = -36.168, wait = 5000 },
    { x = -3.526, y = -6.822, z = -34.548 },
    { x = -3.605, y = -6.951, z = -32.150 },
    { x = -3.696, y = -6.876, z = -29.409 },
    { x = -3.820, y = -6.919, z = -25.643 },
    { x = -3.935, y = -7.808, z = -22.173 },
    { x = -4.101, y = -8.952, z = -17.130 },
    { x = -3.577, y = -8.340, z = -8.364, wait = 5000 },
    { x = -4.101, y = -8.952, z = -17.130 },
    { x = -3.935, y = -7.808, z = -22.173 },
    { x = -3.820, y = -6.919, z = -25.643 },
    { x = -3.696, y = -6.876, z = -29.409 },
    { x = -3.605, y = -6.951, z = -32.150 },
    { x = -3.526, y = -6.822, z = -34.548 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
