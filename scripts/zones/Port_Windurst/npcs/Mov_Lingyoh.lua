-----------------------------------
-- Area: Port Windurst
--  NPC: Mov Lingyoh
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 126.616, y = -3.173, z = 169.402 },
    { x = 122.378, y = -3.703, z = 168.924 },
    { x = 115.305, y = -4.065, z = 168.054 },
    { x = 107.949, y = -4.679, z = 166.991 },
    { x = 99.219, y = -4.403, z = 165.724 },
    { x = 98.697, y = -4.245, z = 165.362 },
    { x = 98.102, y = -3.970, z = 164.525 },
    { x = 89.491, y = -4.000, z = 149.337 },
    { x = 98.102, y = -3.970, z = 164.525 },
    { x = 98.697, y = -4.245, z = 165.362 },
    { x = 99.219, y = -4.403, z = 165.724 },
    { x = 107.949, y = -4.679, z = 166.991 },
    { x = 115.305, y = -4.065, z = 168.054 },
    { x = 122.378, y = -3.703, z = 168.924 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
