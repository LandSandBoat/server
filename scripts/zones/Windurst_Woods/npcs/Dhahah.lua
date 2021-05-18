-----------------------------------
-- Area: Windurst Woods
--  NPC: Dhahah
-----------------------------------
local entity = {}

local path =
{
    12.309, 0.000, 69.636,
    19.116, 0.000, 87.066
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
