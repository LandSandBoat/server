-----------------------------------
-- Area: Windurst Woods
--  NPC: Patsaa Maehoc
-----------------------------------
local entity = {}

local path =
{
-12.900, -4.250, 54.047,    -- TODO: wait at location for 1 seconds
0.655, -4.250, 53.641       -- TODO: wait at location for 1 seconds
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
    player:startEvent(427)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
