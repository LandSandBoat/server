-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Chocobo
-- Chocobo
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    16.998, 2.200, -88.134,
    16.998, 2.200, -88.134,
    16.998, 2.200, -88.134,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
    11.348, 2.200, -87.631,
    11.348, 2.200, -87.631,
    11.348, 2.200, -87.631,
    11.348, 2.200, -87.631,
    11.348, 2.200, -87.631,
    16.998, 2.200, -88.134,
    16.998, 2.200, -88.134,
    16.998, 2.200, -88.134,
    12.863, 2.200, -92.485,
    12.863, 2.200, -92.485,
    12.863, 2.200, -92.485,
    12.863, 2.200, -92.485,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
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
    player:startEvent(818)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
