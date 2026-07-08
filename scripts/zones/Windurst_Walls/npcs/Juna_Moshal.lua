-----------------------------------
-- Area: Windurst Walls
--  NPC: Juna Moshal
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -0.478, y = -10.000, z = 284.884, wait = 5000 },
    { x = -3.823, y = -10.002, z = 288.595 },
    { x = -3.424, y = -10.000, z = 288.970, wait = 5000 },
    { x = -0.298, y = -10.000, z = 284.675 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
