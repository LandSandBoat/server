-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Bones
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -181, y = 0, z = 99 },
    { x = -152, y = 0, z = 105 },
    { x = -149, y = 0, z = 125 },
    { x = -123, y = 0, z = 140 },
    { x = -124, y = 0, z = 182 },
    { x = -136, y = 0, z = 190 },
    { x = -162, y = 0, z = 190 },
    { x = -168, y = 0, z = 195 },
    { x = -170, y = 0, z = 240 },
    { x =  172, y = 0, z = 256 },
    { x = -150, y = 0, z = 278 },
    { x = -174, y = 0, z = 253 },
    { x = -167, y = 0, z = 189 },
    { x = -176, y = 0, z = 177 },
    { x = -174, y = 0, z = 132 },
    { x = -152, y = 0, z = 123 },
    { x = -152, y = 0, z = 104 },
    { x = -181, y = 0, z = 99 },
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
