-----------------------------------
-- Area: Port Windurst
--  NPC: Newlyn
-- Type: Standard NPC
-- !pos 200.673 -6.601 108.665 240
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(190)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
