-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Shade
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 2,   y = -1,  z = 57 },
    { x = -14, y =  -5, z = 87 },
    { x = -39, y =  -5, z = 80 },
    { x = -40, y =  -3, z = 36 },
    { x = -2,  y = -1,  z = 42 },
    { x = 1,   y = -1,  z = 49 },
    { x = 34,  y = -2,  z = 49 },
    { x = 61,  y = -2,  z = 38 },
    { x = 76,  y = -2,  z = 25 },
    { x = 138, y =  -2, z = 60 },
    { x = 76,  y = -2,  z = 25 },
    { x = 61,  y = -2,  z = 38 },
    { x = 34,  y = -2,  z = 49 },
    { x = 1,   y = -1,  z = 49 },
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
