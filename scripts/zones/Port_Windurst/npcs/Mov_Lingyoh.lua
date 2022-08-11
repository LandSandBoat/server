-----------------------------------
-- Area: Port Windurst
--  NPC: Mov Lingyoh
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    126.616, -3.173, 169.402,
    122.378, -3.703, 168.924,
    115.305, -4.065, 168.054,
    107.949, -4.679, 166.991,
    99.219, -4.403, 165.724,
    98.697, -4.245, 165.362,
    98.102, -3.970, 164.525,
    89.491, -4.000, 149.337,
    98.102, -3.970, 164.525,
    98.697, -4.245, 165.362,
    99.219, -4.403, 165.724,
    107.949, -4.679, 166.991,
    115.305, -4.065, 168.054,
    122.378, -3.703, 168.924,
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
    player:startEvent(345)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
