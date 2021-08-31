-----------------------------------
-- Area: Al Zahbi
--  NPC: Ugahar
-- Type: Standard NPC
-- !pos 52.262 -1 123.185 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(238)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
