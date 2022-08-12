-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Hashayra
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    96.832, -6.000, -110.566, -- TODO: stays at point for 1 second then rotates to R: 146 and waits 1 second.
    86.308, -6.000, -105.927, -- TODO: stays at point for 1 second then rotates to R: 14 and waits 1 second.
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
    player:startEvent(676)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
