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
    {x = -72.580, y = -10.000, z = 115.877, wait = 5000},
    {x = -68.580, y = -10.002, z = 118.223},
    {x = -66.538, y = -10.505, z = 119.421},
    {x = -63.684, y = -11.289, z = 121.096},
    {x = -61.175, y = -11.926, z = 122.568},
    {x = -59.242, y = -12.416, z = 123.703, wait = 5000},
    {x = -61.175, y = -11.926, z = 122.568},
    {x = -63.684, y = -11.289, z = 121.096},
    {x = -66.538, y = -10.505, z = 119.421},
    {x = -68.580, y = -10.002, z = 118.223},
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
    npc:pathThrough(path, xi.path.flag.PATROL)
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
