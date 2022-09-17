-----------------------------------
-- Area: Port Windurst
--  NPC: Reiso-Haroiso
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    {x = 45.821, y = -5.000, z = 121.300},
    {x = 45.736, z = 124.757},
    {x = 45.669, z = 127.514},
    {x = 45.736, z = 124.757},
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
    npc:pathThrough(path, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(334)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
