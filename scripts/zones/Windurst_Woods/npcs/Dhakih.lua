-----------------------------------
-- Area: Windurst Woods
--  NPC: Dhakih
-----------------------------------
local entity = {}

local path =
{
3.596, 0.000, 78.553,   -- TODO: wait at location for 10 seconds
-4.010, 0.000, 79.261   -- TODO: wait at location for 18 seconds
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
