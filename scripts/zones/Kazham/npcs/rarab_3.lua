-----------------------------------
-- Area: Kazham
--  NPC: Rarab
-- Nonstandard NPC w/o Nametag
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 98.459, y = -14.000, z = -102.772, wait = 5000 },
    { x = 103.203, y = -14.000, z = -103.309, wait = 5000 },
    { x = 100.614, y = -14.000, z = -100.131, wait = 5000 },
    { x = 96.192, y = -14.000, z = -104.170, wait = 5000 },
    { x = 97.2054, y = -14.000, z = -99.911, wait = 5000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, bit.bor(xi.path.flag.PATROL, xi.path.flag.RUN))
end

return entity
