-----------------------------------
-- Area: Windurst Waters
--  NPC: Yohra-Ora
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    {x = -44.506, y = -5.000, z = 74.003, wait = 5000},
    {x = -32.241, y = -5.000, z = 74.480, wait = 5000},
    {x = -39.187, y = -5.000, z = 78.766, wait = 5000},
    {x = -44.506, y = -5.000, z = 74.003, wait = 5000},
    {x = -39.187, y = -5.000, z = 78.766, wait = 5000},
    {x = -32.241, y = -5.000, z = 74.480, wait = 5000},
    {x = -39.187, y = -5.000, z = 78.766, wait = 5000},
    {x = -32.241, y = -5.000, z = 74.480, wait = 5000},
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
    npc:pathThrough(path, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(565)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
