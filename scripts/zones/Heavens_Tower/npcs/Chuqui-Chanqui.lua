-----------------------------------
-- Area: Heaven's Tower
--  NPC: Chuqui-Chanqui
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -18.932, 0.500, -6.795,
    -21.262, 0.500, 0.276,
    -21.262, 0.500, 0.276,
    -21.262, 0.500, 0.276,
    -21.262, 0.500, 0.276,
    -21.262, 0.500, 0.276,
    -21.262, 0.500, 0.276,
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
    player:startEvent(80)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
