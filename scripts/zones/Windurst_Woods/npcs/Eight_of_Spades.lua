-----------------------------------
-- Area: Windurst Woods
--  NPC: Eight of Spades
-----------------------------------
local entity = {}

local path =
{
    96.635, -4.864, -79.593,
    92.001, -4.534, -75.174,
    96.395, -4.864, -79.364,
    89.948, -4.790, -62.213,
    91.566, -4.567, -74.429
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
    player:startEvent(268)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
