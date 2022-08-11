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
    -21.048, -0.284, 103.128,
    -22.647, -0.125, 97.883,
    -23.250, -0.107, 96.828, -- Force turn.
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.647, -0.125, 97.883,
    -21.318, -0.298, 103.149, -- Force turn.
    -21.048, -0.284, 103.128,
    -21.048, -0.284, 103.128,
    -21.048, -0.284, 103.128,
    -21.048, -0.284, 103.128,
    -21.048, -0.284, 103.128,
    -21.048, -0.284, 103.128,
    -21.048, -0.284, 103.128,
    -21.048, -0.284, 103.128,
    -21.048, -0.284, 103.128,
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
