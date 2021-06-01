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
    54.220, -14.000, -8.204,    -- TODO: wait at location for 10 seconds
    53.541, -14.000, 6.536,     -- TODO: wait at location for 10 seconds
    41.340, -14.000, 7.727,     -- TODO: wait at location for 10 seconds
    41.338, -14.000, -9662      -- TODO: wait at location for 10 seconds
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
    player:startEvent(706)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
