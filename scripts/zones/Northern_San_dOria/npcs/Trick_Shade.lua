-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Shade
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -133, y = 12, z = 267 },
    { x = -127, y = 12, z = 208 },
    { x = -118, y = 6,  z = 198 },
    { x = -128, y = 0,  z = 186 },
    { x = -125, y = 0,  z = 141 },
    { x = -141, y = 0,  z = 128 },
    { x = -172, y = 0,  z = 137 },
    { x = -175, y = 4,  z = 162 },
    { x = -174, y = 0,  z = 180 },
    { x = -165, y = 0,  z = 190 },
    { x = -167, y = 4,  z = 210 },
    { x = -170, y = 0,  z = 235 },
    { x = -172, y = 0,  z = 256 },
    { x = -163, y = 4,  z = 267 },
    { x = -168, y = 4,  z = 272 },
    { x = -173, y = 4,  z = 269 },
    { x = -182, y = 9,  z = 279 },
    { x = -176, y = 9,  z = 282 },
    { x = -157, y = 12, z = 261 },
    { x = -148, y = 12, z = 260 },
    { x = -133, y = 12, z = 267 },
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
