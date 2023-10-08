-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Phantom
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 2,   y = -1,  z = 18 },
    { x = -2,  y = -1,  z = 37 },
    { x = -54, y = -3,  z =  40 },
    { x = -78, y = -3,  z =  63 },
    { x = -81, y = -5,  z =  86 },
    { x = -52, y = -5,  z =  86 },
    { x = -56, y = -3,  z =  64 },
    { x = -68, y = -3,  z =  52 },
    { x = -40, y = -3,  z =  38 },
    { x = -40, y = -5,  z =  86 },
    { x = -9,  y = -5,  z = 86 },
    { x = -3,  y = -1,  z = 71 },
    { x = -7,  y = -1,  z = 27 },
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
