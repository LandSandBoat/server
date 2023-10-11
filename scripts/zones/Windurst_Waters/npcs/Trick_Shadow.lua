-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Shadow
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 185, y =  0,  z = -21 },
    { x = 142, y =  0,  z = -16 },
    { x = 162, y =  -1, z =  9 },
    { x = 130, y =  -2, z =  34 },
    { x = 105, y =  -2, z =  70 },
    { x = 124, y =  -2, z =  98 },
    { x = 124, y =  -2, z =  112 },
    { x = 157, y =  -2, z =  136 },
    { x = 150, y =  -2, z =  126 },
    { x = 140, y =  -2, z =  128 },
    { x = 124, y =  -2, z =  112 },
    { x = 124, y =  -2, z =  98 },
    { x = 105, y =  -2, z =  70 },
    { x = 130, y =  -2, z =  34 },
    { x = 162, y =  -1, z =  9 },
    { x = 162, y =  0,  z = -3 },
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
