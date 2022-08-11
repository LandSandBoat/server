-----------------------------------
-- Area: Windurst Woods
--  NPC: Dhahih
-- Nonstandard Moving NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    6.110, 0.000, 122.311,
    6.110, 0.000, 122.311,
    6.110, 0.000, 122.311,
    6.110, 0.000, 122.311,
    6.110, 0.000, 122.311,
    6.110, 0.000, 122.311,
    6.110, 0.000, 122.311,
    6.110, 0.000, 122.311,
    15.913, 0.000, 111.901,
    20.867, 0.000, 106.642,
    20.867, 0.000, 106.642,
    20.867, 0.000, 106.642,
    20.867, 0.000, 106.642,
    20.867, 0.000, 106.642,
    20.867, 0.000, 106.642,
    20.867, 0.000, 106.642,
    20.867, 0.000, 106.642,
    15.913, 0.000, 111.901,
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
