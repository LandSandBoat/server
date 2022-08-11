-----------------------------------
-- Area: Port Windurst
--  NPC: Reiso-Haroiso
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    45.821, -5.000, 121.300,
    45.736, -5.000, 124.757,
    45.669, -5.000, 127.514,
    45.736, -5.000, 124.757,
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
    player:startEvent(334)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
