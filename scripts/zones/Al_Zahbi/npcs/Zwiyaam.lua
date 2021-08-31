-----------------------------------
-- Area: Al Zahbi
--  NPC: Zwiyaam
-- Type: Standard NPC
-- !pos 14.814 -7.667 41.889 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(247)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
