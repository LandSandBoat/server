-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Spirit
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -173, y = 0,  z = 129 },
    { x = -174, y = 4,  z = 160 },
    { x = -175, y = 0,  z = 179 },
    { x = -165, y = 0,  z = 189 },
    { x = -165, y = 4,  z = 208 },
    { x = -146, y = 12, z = 210 },
    { x = -131, y = 12, z = 227 },
    { x = -130, y = 12, z = 245 },
    { x = -139, y = 12, z = 253 },
    { x = -157, y = 12, z = 257 },
    { x = -141, y = 12, z = 270 },
    { x = -121, y = 12, z = 254 },
    { x = -132, y = 12, z = 231 },
    { x = -156, y = 12, z = 163 },
    { x = -196, y = 9,  z = 162 },
    { x = -199, y = 9,  z = 169 },
    { x = -183, y = 4,  z = 168 },
    { x = -181, y = 4,  z = 162 },
    { x = -174, y = 4,  z = 162 },
    { x = -173, y = 0,  z = 181 },
    { x = -162, y = 0,  z = 187 },
    { x = -131, y = 0,  z = 187 },
    { x = -123, y = 0,  z = 178 },
    { x = -124, y = 0,  z = 143 },
    { x = -138, y = 0,  z = 126 },
    { x = -173, y = 0,  z = 129 },
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
