-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Shadow
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x =  60,  y = 0, z = 33 },
    { x =  24,  y = 0, z = 46 },
    { x =  17,  y = 0, z = 58 },
    { x = -1,   y = 0, z = 65 },
    { x = -21,  y = 0, z = 55 },
    { x = -31,  y = 0, z = 62 },
    { x = -113, y = 0, z = 63 },
    { x = -133, y = 0, z = 83 },
    { x = -141, y = 0, z = 106 },
    { x = -159, y = 0, z = 106 },
    { x = -157, y = 0, z = 89 },
    { x = -142, y = 0, z = 88 },
    { x = -110, y = 0, z = 57 },
    { x = -96,  y = 0, z = 58 },
    { x = -89,  y = 0, z = 61 },
    { x = -73,  y = 0, z = 57 },
    { x = -27,  y = 0, z = 57 },
    { x = -13,  y = 0, z = 52 },
    { x =  12,  y = 0, z = 53 },
    { x =  52,  y = 0, z = 32 },
    { x =  60,  y = 0, z = 33 },
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
