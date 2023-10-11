-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Skeleton
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -58, y =  -1, z =  -161 },
    { x = -59, y =  -2, z =  -199 },
    { x = -52, y =  -1, z =  -162 },
    { x = -51, y =  -2, z =  -118 },
    { x = -35, y =  -2, z =  -102 },
    { x = -3,  y = -2,  z = -135 },
    { x = -3,  y = -4,  z = -179 },
    { x = -44, y =  -1, z =  -180 },
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
