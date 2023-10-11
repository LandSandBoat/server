-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Ghost
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -124, y = 0, z = 70 },
    { x = -110, y = 0, z = 56 },
    { x = -96,  y = 0, z = 57 },
    { x = -89,  y = 0, z = 61 },
    { x = -74,  y = 0, z = 58 },
    { x = -27,  y = 0, z = 57 },
    { x = -12,  y = 0, z = 52 },
    { x = -6,   y = 0, z = 57 },
    { x =  8,   y = 0, z = 56 },
    { x =  14,  y = 0, z = 50 },
    { x =  13,  y = 0, z = 27 },
    { x =  8,   y = 0, z = 22 },
    { x = -8,   y = 0, z = 23 },
    { x = -13,  y = 0, z = 27 },
    { x = -21,  y = 0, z = 56 },
    { x = -42,  y = 0, z = 62 },
    { x = -112, y = 0, z = 62 },
    { x = -134, y = 0, z = 85 },
    { x = -140, y = 0, z = 106 },
    { x = -158, y = 0, z = 107 },
    { x = -157, y = 0, z = 89 },
    { x = -143, y = 0, z = 89 },
    { x = -124, y = 0, z = 70 },
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
