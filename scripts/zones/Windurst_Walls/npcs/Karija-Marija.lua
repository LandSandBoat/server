-----------------------------------
-- Area: Windurst Walls
--  NPC: Karija-Marija
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

-- Karija-Marija doesn't stop walking, so all the points
-- below are based on the last position of his current
-- rotation as he doesnt walk in a straight line.
-- TODO: npc doesnt need to stop at point to change direction
local path =
{
    77.33, -2.50, -90.45,
    64.40, -2.43, -76.45,
    58.33, -2.37, -74.28,
    58.33, -2.37, -74.28,
    64.10, -2.42, -76.29,
    77.33, -2.50, -90.45,
    81.86, -2.50, -101.57,
    82.16, -2.50, -114.07,
    81.89, -2.50, -101.63,
    77.38, -2.50, -90.59
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
