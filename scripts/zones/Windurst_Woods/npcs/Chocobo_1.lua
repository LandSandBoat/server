-----------------------------------
-- Area: Windurst Woods
--  NPC: Chocobo
-- Nonstandard Moving NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 124.632, y = -5.000, z = -111.154, wait = 2000 },
    { x = 128.215, y = -5.000, z = -104.243, wait = 2000 },
    { x = 124.660, y = -5.000, z = -110.186, wait = 2000 },
    { x = 124.632, y = -5.000, z = -111.154, wait = 2000 },
    { x = 121.099, y = -5.000, z = -108.742, wait = 2000 },
    { x = 124.660, y = -5.000, z = -110.186, wait = 2000 },
    { x = 128.215, y = -5.000, z = -104.243, wait = 2000 },
    { x = 124.669, y = -5.000, z = -102.273, wait = 2000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
