-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Ghost
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -56,  y = -5, z = 222 },
    { x = -40,  y = -5, z = 216 },
    { x = -41,  y = -5, z = 200 },
    { x = -49,  y = -6, z = 186 },
    { x = -40,  y = -5, z = 164 },
    { x = -39,  y = -3, z = 39 },
    { x = -31,  y = -3, z = 32 },
    { x = -32,  y = -2, z = 6 },
    { x = -45,  y = -2, z = 1 },
    { x = -98,  y = -3, z = 24 },
    { x = -110, y = -2, z =  50 },
    { x = -78,  y = -3, z = 64 },
    { x = -81,  y = -5, z = 87 },
    { x = -40,  y = -5, z = 86 },
    { x = -40,  y = -5, z = 168 },
    { x = -49,  y = -6, z = 186 },
    { x = -33,  y = -4, z = 223 },
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
