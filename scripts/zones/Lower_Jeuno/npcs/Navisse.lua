-----------------------------------
-- Area: Lower Jeuno
--  NPC: Navisse
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -63.130, y = 6.000, z = -86.860, rotation = 150, wait = 3000 },
    { x = -54.336, z = -91.384, rotation = 22, wait = 3000 },
    { x = -63.130, z = -86.860, rotation = 150, wait = 3000 },
    { x = -64.590, z = -89.360, rotation = 150, wait = 3000 },
    { x = -63.125, z = -86.860, rotation = 150, wait = 3000 },
    { x = -55.681, z = -94.332, rotation = 22, wait = 3000 },
    { x = -54.336, z = -91.384, rotation = 22, wait = 3000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
