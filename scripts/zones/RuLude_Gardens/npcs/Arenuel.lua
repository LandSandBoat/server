-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Arenuel
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.953, 1.996, 59.933, -- Force turn.
    36.089, 1.996, 59.933,
    36.089, 1.996, 59.933,
    36.089, 1.996, 59.933,
    36.089, 1.996, 59.933,
    36.089, 1.996, 59.933,
    36.089, 1.996, 59.933,
    35.713, 1.996, 70.939, -- Force turn.
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    36.041, 1.996, 62.952, -- Force Turn.
    36.317, 1.996, 62.952,
    36.317, 1.996, 62.952,
    36.317, 1.996, 62.952,
    36.317, 1.996, 62.952,
    36.317, 1.996, 62.952,
    36.317, 1.996, 62.952,
    35.953, 1.996, 59.933, -- Force turn.
    36.089, 1.996, 59.993,
    36.089, 1.996, 59.993,
    36.089, 1.996, 59.993,
    36.089, 1.996, 59.993,
    36.089, 1.996, 59.993,
    36.089, 1.996, 59.993,
    35.713, 1.996, 70.939, -- Force turn.
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
    player:startEvent(120)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
