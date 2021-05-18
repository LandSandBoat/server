-----------------------------------
-- Area: Windurst Woods
--  NPC: Dhahih
-----------------------------------
local entity = {}

local path =
{
6.110, 0.000, 122.311,  -- TODO: wait at location for 6 seconds
20.867, 0.000, 106.642  -- TODO: wait at location for 6 seconds
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
