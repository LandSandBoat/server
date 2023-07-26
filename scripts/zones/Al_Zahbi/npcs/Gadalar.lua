-----------------------------------
-- Area: Al Zahbi
--  NPC: Gadalar
-- Type: Fireserpent General
-- !pos -105.979 -7 39.692 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(266)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
