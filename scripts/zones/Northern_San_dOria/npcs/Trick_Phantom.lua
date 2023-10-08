-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Ghost
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -232, y = -4, z = 106 },
    { x = -182, y = 0,  z = 106 },
    { x = -180, y = 0,  z = 97 },
    { x = -182, y = 4,  z = 80 },
    { x = -239, y = 8,  z = 77 },
    { x = -239, y = 8,  z = 13 },
    { x = -221, y = 8,  z = 13 },
    { x = -220, y = 8,  z = 61 },
    { x = -192, y = 4,  z = 76 },
    { x = -176, y = 4,  z = 83 },
    { x = -176, y = 0,  z = 105 },
    { x = -232, y = -4, z = 106 },
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
