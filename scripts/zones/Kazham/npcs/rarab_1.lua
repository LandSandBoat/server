-----------------------------------
-- Area: Kazham
--  NPC: Rarab
-- Nonstandard NPC w/o Nametag
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 98.726, y = -14.000, z = -100.304, wait = 2000 },
    { x = 102.019, z = -103.237, wait = 2000 },
    { x = 103.099, z = -100.815, wait = 2000 },
    { x = 100.966, z = -101.352, wait = 2000 },
    { x = 96.692, z = -102.157, wait = 2000 },
    { x = 96.508, z = -100.242, wait = 2000 },
    { x = 100.919, z = -104.135, wait = 2000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, bit.bor(xi.path.flag.PATROL, xi.path.flag.RUN))
end

return entity
