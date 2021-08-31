-----------------------------------
-- Area: Al Zahbi
--  NPC: Sujyahn
-- Type: Standard NPC
-- !pos -48.213 -1 34.723 48
-----------------------------------
local entity = {}

local path =
{
    -50.871, 0.000, 32.143,     -- TODO: wait at location for 2 seconds, then turns around and waits 3-4 seconds
    -32.024, 0.000, 50.447      -- TODO: wait at location for 2 seconds, then turns around and waits 3-4 seconds
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
    player:startEvent(242)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
