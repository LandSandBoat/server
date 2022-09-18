-----------------------------------
-- Area: Windurst Woods
--  NPC: Dhakoh
-- Nonstandard Moving NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    {x = -21.048, y = -0.284, z = 103.128, wait = 8000},
    {x = -22.647, y = -0.125, z = 97.883},
    {x = -23.250, y = -0.107, z = 96.828}, -- Force turn.
    {x = -22.980, y = -0.090, z = 96.793, wait = 8000},
    {x = -22.647, y = -0.125, z = 97.883},
    {x = -21.318, y = -0.298, z = 103.149}, -- Force turn.
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
    npc:pathThrough(path, xi.path.flag.PATROL)
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
