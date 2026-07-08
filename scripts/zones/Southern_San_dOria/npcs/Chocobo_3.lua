-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Chocobo
-- Chocobo
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 13.350, y = 2.200, z = -100.356, wait = 6000 },
    { x = 17.079, z = -100.110 },
    { x = 13.350, z = -100.356, wait = 6000 },
    { x = 19.627, z = -97.389 },
    { x = 17.754, z = -99.761 },
    { x = 19.627, z = -97.389 },
    { x = 16.944, z = -97.278 },
    { x = 17.707, z = -99.819 },
    { x = 19.627, z = -97.389 },
    { x = 17.597, z = -96.827 },
    { x = 19.627, z = -97.389 },
    { x = 17.407, z = -99.630 },
    { x = 17.345, z = -96.794 },
    { x = 19.864, z = -97.119 },
    { x = 17.407, z = -99.630 },
    { x = 17.345, z = -96.794 },
    { x = 17.407, z = -99.630 },
    { x = 19.864, z = -97.119 },
    { x = 16.354, z = -100.158 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
