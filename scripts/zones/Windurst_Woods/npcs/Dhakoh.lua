-----------------------------------
-- Area: Windurst Woods
--  NPC: Dhakoh
-----------------------------------
local entity = {}

local path =
{
    -22.980, -0.090, 96.793,
    -20.951, -0.294, 103.448
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
