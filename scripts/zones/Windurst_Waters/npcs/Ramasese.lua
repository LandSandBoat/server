-----------------------------------
-- Area: Windurst Waters
--  NPC: Ramasese
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    119.807, -1.875, 95.288,
    119.807, -1.875, 95.288,
    119.807, -1.875, 95.288,
    119.807, -1.875, 95.288,
    119.807, -1.875, 95.288,
    119.807, -1.875, 95.288,
    119.807, -1.875, 95.288,
    113.644, -1.907, 87.671,
    109.390, -2.000, 84.130,
    108.582, -2.000, 82.628,
    108.198, -2.000, 81.088,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    108.198, -2.000, 81.088,
    108.582, -2.000, 82.628,
    109.390, -2.000, 84.130,
    113.644, -1.907, 87.671,
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
end

entity.onPath = function(npc)
    xi.path.patrol(npc, path)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(584)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
