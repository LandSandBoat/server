-----------------------------------
-- Area: Windurst Woods
--  NPC: Dhahah
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    18.947, 0.000, 86.480,
    16.665, 0.000, 78.920,
    12.472, 0.000, 70.061,
    16.665, 0.000, 78.920,
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
end

entity.onPath = function(npc)
    xi.path.patrol(npc, path)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
