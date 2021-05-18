-----------------------------------
-- Area: Windurst Woods
--  NPC: Orahi-Karapahi
-- Working 100%
-----------------------------------
local entity = {}

local path =
{
63.612, -4.250, 102.695,    -- TODO: wait at location for 1 seconds
58.772, -4.250, 103.357     -- TODO: wait at location for 1 seconds
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
    player:startEvent(413)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
