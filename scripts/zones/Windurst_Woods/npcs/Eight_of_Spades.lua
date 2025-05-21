-----------------------------------
-- Area: Windurst Woods
--  NPC: Eight of Spades
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 95.891, y = -4.786, z = -77.369 },
    { x = 94.799, y = -4.769, z = -74.579 },
    { x = 93.615, y = -4.701, z = -71.557 },
    { x = 90.963, y = -4.615, z = -64.793 },
    { x = 89.878, y = -4.800, z = -62.142 },
    { x = 90.144, y = -4.706, z = -64.076 },
    { x = 90.510, y = -4.666, z = -66.743 },
    { x = 91.520, y = -4.574, z = -74.101 },
    { x = 91.925, y = -4.532, z = -74.990 },
    { x = 92.753, y = -4.557, z = -75.877 },
    { x = 94.909, y = -4.752, z = -77.947 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
