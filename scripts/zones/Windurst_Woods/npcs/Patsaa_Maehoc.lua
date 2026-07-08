-----------------------------------
-- Area: Windurst Woods
--  NPC: Patsaa Maehoc
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 0.665, y = -4.250, z = 53.641, wait = 4000 },
    { x = -5.685, y = -4.250, z = 53.831 },
    { x = -10.590, y = -4.250, z = 53.978 },
    { x = -12.900, y = -4.250, z = 54.047, wait = 4000 },
    { x = -10.590, y = -4.250, z = 53.978 },
    { x = -5.685, y = -4.250, z = 53.831 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
