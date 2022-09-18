-----------------------------------
-- Area: Port San d'Oria
--  NPC: Brifalien
-- Involved in Quests: Riding on the Clouds
-- !pos -20 -4 -74 232
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    {x = -19.298, y = -4.000, z = -74.169, wait = 3000},
    {x = -20.027, z = -74.828},
    {x = -20.577, z = -74.736},
    {x = -20.567, z = -73.723},
    {x = -20.134, z = -73.353},
    {x = -19.298, z = -74.169, wait = 3000},
    {x = -20.577, z = -74.736, wait = 3000},
    {x = -20.134, z = -73.353, wait = 3000},
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
    npc:pathThrough(path, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
