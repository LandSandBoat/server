-----------------------------------
-- Area: Windurst Waters
--  NPC: Kyokyo
-- Nonstandard Moving NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -208.588, -3.000, -61.340,
    -208.588, -3.000, -61.340,
    -208.588, -3.000, -61.340,
    -213.073, -3.000, -58.185,
    -213.073, -3.000, -58.185,
    -213.073, -3.000, -58.185,
    -213.073, -3.000, -58.185,
    -211.882, -3.000, -64.415,
    -211.882, -3.000, -64.415,
    -211.882, -3.000, -64.415,
    -211.882, -3.000, -64.415,
    -213.073, -3.000, -58.185,
    -213.073, -3.000, -58.185,
    -213.073, -3.000, -58.185,
    -213.073, -3.000, -58.185,
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
end

entity.onPath = function(npc)
    xi.path.patrol(npc, path, xi.path.flag.RUN)
end

return entity
