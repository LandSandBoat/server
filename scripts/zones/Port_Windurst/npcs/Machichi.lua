-----------------------------------
-- Area: Port Windurst
--  NPC: Machichi
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -106.567, -5.000, 169.822,
    -106.567, -5.000, 169.822,
    -106.567, -5.000, 169.822,
    -106.567, -5.000, 169.822,
    -106.567, -5.000, 169.822,
    -106.567, -5.000, 169.822,
    -106.567, -5.000, 169.822,
    -106.567, -5.000, 169.822,
    -113.700, -5.118, 178.268,
    -113.700, -5.118, 178.268,
    -113.700, -5.118, 178.268,
    -113.700, -5.118, 178.268,
    -113.700, -5.118, 178.268,
    -108.809, -5.000, 172.477,
    -106.296, -5.000, 170.138,
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
    player:startEvent(325)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
