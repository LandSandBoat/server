-----------------------------------
-- Area: Bastok Mines
--  NPC: Black Mud
-- Starts & Finishes Quest: Drachenfall
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    35.243, 7.000, -1.829,
    35.243, 7.000, -1.829,
    35.243, 7.000, -1.829,
    35.243, 7.000, -1.829,
    35.243, 7.000, -1.829,
    35.243, 7.000, -1.829,
    35.243, 7.000, -1.829,
    35.243, 7.000, -1.829,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
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
