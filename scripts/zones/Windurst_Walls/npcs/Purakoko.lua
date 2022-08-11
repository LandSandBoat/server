-----------------------------------
-- Area: Windurst Walls
--  NPC: Purakoko
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -68.580, -10.002, 118.223,
    -66.538, -10.505, 119.421,
    -63.684, -11.289, 121.096,
    -61.175, -11.926, 122.568,
    -59.242, -12.416, 123.703,
    -59.242, -12.416, 123.703,
    -59.242, -12.416, 123.703,
    -59.242, -12.416, 123.703,
    -59.242, -12.416, 123.703,
    -59.242, -12.416, 123.703,
    -59.242, -12.416, 123.703,
    -59.242, -12.416, 123.703,
    -61.175, -11.926, 122.568,
    -63.684, -11.289, 121.096,
    -66.538, -10.505, 119.421,
    -68.580, -10.002, 118.223,
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
    player:startEvent(318)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
