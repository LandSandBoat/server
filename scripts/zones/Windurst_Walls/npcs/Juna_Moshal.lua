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
    -0.478, -10.000, 284.884,
    -0.478, -10.000, 284.884,
    -0.478, -10.000, 284.884,
    -0.478, -10.000, 284.884,
    -0.478, -10.000, 284.884,
    -0.478, -10.000, 284.884,
    -3.823, -10.002, 288.595,
    -3.424, -10.000, 288.970,
    -3.424, -10.000, 288.970,
    -3.424, -10.000, 288.970,
    -3.424, -10.000, 288.970,
    -3.424, -10.000, 288.970,
    -3.424, -10.000, 288.970,
    -0.298, -10.000, 284.675,
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
    player:startEvent(327)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
