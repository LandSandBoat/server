-----------------------------------
-- Area: Windurst Walls
--  NPC: Juna Moshal
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    {x = -0.478, y = -10.000, z = 284.884, wait = 5000},
    {x = -3.823, y = -10.002, z = 288.595},
    {x = -3.424, y = -10.000, z = 288.970, wait = 5000},
    {x = -0.298, y = -10.000, z = 284.675},
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
    npc:pathThrough(path, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(327)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
