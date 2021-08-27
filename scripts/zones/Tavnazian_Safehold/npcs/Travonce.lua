-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Travonce
-- Type: Standard NPC
-- !pos -89.068 -14.367 -0.030 26
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(210)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
