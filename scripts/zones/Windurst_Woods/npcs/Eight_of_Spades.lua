-----------------------------------
-- Area: Windurst Woods
--  NPC: Eight of Spades
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    95.891, -4.786, -77.369,
    94.799, -4.769, -74.579,
    93.615, -4.701, -71.557,
    90.963, -4.615, -64.793,
    89.878, -4.800, -62.142,
    90.144, -4.706, -64.076,
    90.510, -4.666, -66.743,
    91.520, -4.574, -74.101,
    91.925, -4.532, -74.990,
    92.753, -4.557, -75.877,
    94.909, -4.752, -77.947,
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
    player:startEvent(268)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
