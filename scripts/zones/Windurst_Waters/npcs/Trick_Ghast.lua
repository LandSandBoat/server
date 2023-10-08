-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Ghast
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 144, y = 0,  z = 160 },
    { x = 147, y = 0,  z = 149 },
    { x = 147, y = -2, z =  134 },
    { x = 124, y = -2, z =  112 },
    { x = 122, y = -2, z =  93 },
    { x = 108, y = -2, z =  81 },
    { x = 107, y = -2, z =  65 },
    { x = 135, y = -2, z =  32 },
    { x = 159, y = -1, z =  9 },
    { x = 145, y = 0,  z = -14 },
    { x = 172, y = 0,  z = -15 },
    { x = 159, y = -1, z =  9 },
    { x = 135, y = -2, z =  32 },
    { x = 107, y = -2, z =  65 },
    { x = 108, y = -2, z =  81 },
    { x = 122, y = -2, z =  93 },
    { x = 124, y = -2, z =  112 },
    { x = 147, y = -2, z =  134 },
    { x = 147, y = 0,  z = 166 },
    { x = 148, y = -2, z =  207 },
    { x = 98,  y = -2, z = 202 },
    { x = 99,  y = -2, z = 170 },
    { x = 116, y = 0,  z = 171 },
    { x = 126, y = 0,  z = 186 },
    { x = 147, y = 0,  z = 184 },
    { x = 147, y = 0,  z = 167 },
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
