-----------------------------------
-- Area: Windurst Walls
--  NPC: Suhie-Kaihie
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -151.273, -2.500, 149.672,
    -151.273, -2.500, 149.672,
    -151.273, -2.500, 149.672,
    -151.273, -2.500, 149.672,
    -151.273, -2.500, 149.672,
    -151.273, -2.500, 149.672,
    -166.101, -2.500, 149.860,
    -166.101, -2.500, 149.860,
    -166.101, -2.500, 149.860,
    -166.101, -2.500, 149.860,
    -166.101, -2.500, 149.860,
    -166.101, -2.500, 149.860,
    -166.101, -2.500, 149.860,
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
    player:startEvent(291)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
