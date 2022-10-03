-----------------------------------
-- Area: Metalworks
--  NPC: Fariel
-- Type: Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    { x = 54.220, y = -14.000, z = -8.204, wait = 10000 },
    { x = 53.541, z = 6.536, wait = 10000 },
    { x = 41.340, z = 7.727, wait = 10000 },
    { x = 41.338, z = -9.662, wait = 10000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
    npc:pathThrough(path, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(706)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
