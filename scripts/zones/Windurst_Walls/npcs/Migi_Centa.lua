-----------------------------------
-- Area: Windurst Walls
--  NPC: Migi Centa
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    47.213, -10.000, 20.012,
    47.213, -10.000, 20.012,
    47.213, -10.000, 20.012,
    47.213, -10.000, 20.012,
    47.213, -10.000, 20.012,
    47.213, -10.000, 20.012,
    47.213, -10.000, 20.012,
    47.213, -10.000, 20.012,
    52.357, -9.728, 31.661,
    52.357, -9.728, 31.661,
    52.357, -9.728, 31.661,
    52.357, -9.728, 31.661,
    52.357, -9.728, 31.661,
    52.357, -9.728, 31.661,
    52.357, -9.728, 31.661,
    52.357, -9.728, 31.661,
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
    player:startEvent(324)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
