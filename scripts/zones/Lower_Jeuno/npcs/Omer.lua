-----------------------------------
-- Area: Lower Jeuno
--  NPC: Omer
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    {x = -90, y = 0.000, z = -127, rotation = 150, wait = 4000},
    {rotation = 214, wait = 1000},
    {x = -86, y = 0.000, z = -120, rotation = 150, wait = 4000},
    {rotation = 86, wait = 1000},
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
    npc:pathThrough(path, xi.path.flag.PATROL)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
