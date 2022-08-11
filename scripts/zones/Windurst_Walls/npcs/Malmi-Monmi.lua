-----------------------------------
-- Area: Windurst Walls
--  NPC: Malmi-Monmi
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -101.174, -5.450, 148.387,
    -101.174, -5.450, 148.387,
    -101.174, -5.450, 148.387,
    -101.174, -5.450, 148.387,
    -101.174, -5.450, 148.387,
    -101.174, -5.450, 148.387,
    -101.174, -5.450, 148.387,
    -103.634, -5.478, 146.359,
    -103.634, -5.478, 146.359,
    -103.634, -5.478, 146.359,
    -103.634, -5.478, 146.359,
    -103.634, -5.478, 146.359,
    -103.634, -5.478, 146.359,
    -103.634, -5.478, 146.359,
    -101.140, -5.559, 148.788,
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
    player:startEvent(295)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
