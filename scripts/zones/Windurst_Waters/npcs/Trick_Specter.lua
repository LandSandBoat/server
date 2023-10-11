-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Specter
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 106, y =  -2, z =  46 },
    { x = 123, y =  -1, z =  44 },
    { x = 159, y =  -1, z =  10 },
    { x = 159, y =  1,  z = -25 },
    { x = 159, y =  -1, z =  10 },
    { x = 123, y =  -1, z =  44 },
    { x = 106, y =  -2, z =  41 },
    { x = 77,  y = -2,  z = 26 },
    { x = 34,  y = -2,  z = 51 },
    { x = -5,  y = -1,  z = 49 },
    { x = -8,  y = -1,  z = 20 },
    { x = 10,  y = -1,  z = 23 },
    { x = 0,   y = -1,  z = 38 },
    { x = 0,   y = -1,  z = 50 },
    { x = 34,  y = -2,  z = 49 },
    { x = 62,  y = -2,  z = 37 },
    { x = 78,  y = -2,  z = 25 },
    { x = 106, y = -2,  z = 42 },
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
