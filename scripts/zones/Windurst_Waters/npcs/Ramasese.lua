-----------------------------------
-- Area: Windurst Waters
--  NPC: Ramasese
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 119.807, y = -1.875, z = 95.288, wait = 5000 },
    { x = 113.644, y = -1.907, z = 87.671 },
    { x = 109.390, y = -2.000, z = 84.130 },
    { x = 108.582, y = -2.000, z = 82.628 },
    { x = 108.198, y = -2.000, z = 81.088 },
    { x = 107.135, y = -2.000, z = 67.196, wait = 5000 },
    { x = 108.198, y = -2.000, z = 81.088 },
    { x = 108.582, y = -2.000, z = 82.628 },
    { x = 109.390, y = -2.000, z = 84.130 },
    { x = 113.644, y = -1.907, z = 87.671 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
