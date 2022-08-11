-----------------------------------
-- Area: Windurst Waters
--  NPC: Pia
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
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
    player:startEvent(597)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
