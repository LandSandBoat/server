-----------------------------------
-- Area: Windurst Walls
--  NPC: Purakoko
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

-- TODO: Purakoko randomely chooses the following when pathing:
-- Sometimes waits at a point 1-5 seconds.
-- Sometimes before/after waiting, rotates to look at a point.
-- Sometimes she skips going to 3rd point.
local path =
{
-72.580, -10.000, 115.887,
-65.567, -10.786, 120.000,
-59.242, -12.416, 123.703,
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
