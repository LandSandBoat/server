-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Chocobo
-- Chocobo
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 25.019, y = 2.200, z = -90.039, wait = 2000 },
    { x = 24.243, z = -92.376, wait = 2000 },
    { x = 25.019, z = -90.039, wait = 2000 },
    { x = 24.243, z = -92.376, wait = 2000 },
    { x = 26.665, z = -92.299, wait = 2000 },
    { x = 25.019, z = -90.039, wait = 2000 },
    { x = 24.243, z = -92.376, wait = 2000 },
    { x = 26.665, z = -92.299, wait = 2000 },
    { x = 25.019, z = -90.039, wait = 2000 },
    { x = 27.464, z = -90.589, wait = 2000 },
    { x = 24.243, z = -92.376, wait = 2000 },
    { x = 26.665, z = -92.299, wait = 2000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(818)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
