-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Skeleton
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -26, y = 0, z = 58 },
    { x = 4,   y = 0, z = 57 },
    { x = 24,  y = 0, z = 47 },
    { x = 53,  y = 0, z = 32 },
    { x = 90,  y = 0, z = 0 },
    { x = 102, y = 0, z = -11 },
    { x = 114, y = 0, z = -8 },
    { x = 125, y = 0, z = 2 },
    { x = 118, y = 0, z = 1 },
    { x = 104, y = 0, z = -9 },
    { x = 51,  y = 0, z = 33 },
    { x = 27,  y = 0, z = 33 },
    { x = 4,   y = 0, z = 14 },
    { x = -11, y = 0, z = 16 },
    { x = -23, y = 0, z = 25 },
    { x = -22, y = 0, z = 56 },
    { x = -26, y = 0, z = 58 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
    xi.events.harvest.onHalloweenTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, zones[player:getZoneID()].text.TRICK_OR_TREAT)
end

return entity
