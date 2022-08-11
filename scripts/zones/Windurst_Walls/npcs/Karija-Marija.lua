-----------------------------------
-- Area: Windurst Walls
--  NPC: Karija-Marija
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    82.146, -2.500, -113.624,
    81.814, -2.500, -101.618,
    81.406, -2.500, -100.469,
    80.962, -2.500, -99.366,
    80.465, -2.500, -98.145,
    78.268, -2.500, -92.760,
    76.941, -2.500, -90.049,
    75.845, -2.500, -88.848,
    64.879, -2.458, -76.964,
    64.062, -2.425, -76.346,
    62.665, -2.367, -75.797,
    58.706, -2.352, -74.414,
    62.665, -2.367, -75.797,
    64.062, -2.425, -76.346,
    64.879, -2.458, -76.964,
    75.845, -2.500, -88.848,
    76.941, -2.500, -90.049,
    78.268, -2.500, -92.760,
    80.465, -2.500, -98.145,
    80.962, -2.500, -99.366,
    81.406, -2.500, -100.469,
    81.814, -2.500, -101.618,
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
    player:startEvent(317)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
