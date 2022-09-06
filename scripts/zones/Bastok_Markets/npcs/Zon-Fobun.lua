-----------------------------------
-- Area: Bastok Markets
--  NPC: Zon-Fobun
-- !pos -241.293 -3 63.406 235
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -242.254, -2.000, 61.679,
    -242.254, -2.000, 61.679,
    -242.254, -2.000, 61.679,
    -242.254, -2.000, 61.679,
    -242.254, -2.000, 61.679,
    -242.254, -2.000, 61.679,
    -242.254, -2.000, 61.679,
    -240.300, -2.000, 65.194,
    -240.300, -2.000, 65.194,
    -240.300, -2.000, 65.194,
    -240.300, -2.000, 65.194,
    -240.300, -2.000, 65.194,
    -240.300, -2.000, 65.194,
    -240.300, -2.000, 65.194,
    -240.300, -2.000, 65.194,
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
