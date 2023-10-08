-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Spirit
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 37,   y = -4, z = -175 },
    { x = 17,   y = -4, z = -179 },
    { x = -48,  y = -1, z = -179 },
    { x = -62,  y = -1, z = -166 },
    { x = -11,  y = -1, z = -160 },
    { x = -108, y = -1, z = -156 },
    { x = -88,  y = -1, z = -158 },
    { x = -70,  y = -1, z = -162 },
    { x = -49,  y = -1, z = -167 },
    { x = -49,  y = -1, z = -181 },
    { x = -42,  y = -1, z = -179 },
    { x = 17,   y = -4, z = -180 },
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
