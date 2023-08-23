-----------------------------------
-- Area: Windurst Waters
--  NPC: Kyokyo
-- Nonstandard Moving NPC
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -208.588, y = -3.000, z = -61.340, wait = 3000 },
    { x = -213.073, z = -58.185, wait = 3000 },
    { x = -211.882, z = -64.415, wait = 3000 },
    { x = -213.073, z = -58.185, wait = 3000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, bit.bor(xi.path.flag.PATROL, xi.path.flag.RUN))
end

return entity
