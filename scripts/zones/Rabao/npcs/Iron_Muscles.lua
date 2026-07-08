-----------------------------------
-- Area: Rabao
--  NPC: Iron Muscles
-- !pos -38.319, 7.999, 93.138
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -38.319, y = 7.999, z = 93.138, wait = 5000 },
    { x = -23.577, y = 8.021, z = 99.162, wait = 5000 },
    { x = -25.777, y = 8.000, z = 89.811, wait = 5000 },
    { x = -23.749, y = 8.000, z = 83.924, wait = 5000 },
    { x = -32.886, y = 8.000, z = 82.689, wait = 5000 },
    { x = -44.130, y = 8.000, z = 89.012, wait = 5000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
