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
    -209.084, -3.250, -100.559,
    -209.084, -3.250, -100.559,
    -209.084, -3.250, -100.559,
    -209.084, -3.250, -100.559,
    -205.729, -3.108, -98.984,
    -205.729, -3.108, -98.984,
    -205.729, -3.108, -98.984,
    -205.729, -3.108, -98.984,
    -208.634, -3.250, -96.121,
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
end

entity.onPath = function(npc)
    xi.path.patrol(npc, path, xi.path.flag.RUN)
end

return entity
