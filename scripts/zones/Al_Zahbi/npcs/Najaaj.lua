-----------------------------------
-- Area: Al Zahbi
--  NPC: Najaaj
-- Type: Standard NPC
-- !pos 61.563 -1 36.264 48
-----------------------------------
local entity = {}

local path =
{
    40.548, 0.000, 36.430,      -- TODO: wait at location for 2 seconds
    66.711, 0.000, 36.224       -- TODO: wait at location for 2 seconds, then turns around and waits 3-4 seconds
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
    player:startEvent(241)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
