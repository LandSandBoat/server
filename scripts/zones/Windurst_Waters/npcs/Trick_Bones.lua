-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Bones
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -47, y = -3, z = -71 },
    { x = -39, y = -3, z = -56 },
    { x = -8,  y = -2, z = -22 },
    { x = -7,  y = -1, z = 17 },
    { x = -4,  y = -1, z = 67 },
    { x = -16, y = -5, z = 89 },
    { x = -38, y = -5, z = 76 },
    { x = -39, y = -3, z = 38 },
    { x = -7,  y = -1, z = 35 },
    { x = -8,  y = -2, z = -24 },
    { x = -45, y = -2, z = -62 },
    { x = -37, y = -2, z = -88 },
    { x = -36, y = -2, z = -104 },
    { x = -51, y = -2, z = -119 },
    { x = -51, y = -1, z = -165 },
    { x = -42, y = -1, z = -179 },
    { x = -4,  y = -4, z = -180 },
    { x = -4,  y = -2, z = -134 },
    { x = -36, y = -2, z = -102 },
    { x = -36, y = -2, z = -86 },
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
