-----------------------------------
-- Area: Al Zahbi
--  NPC: Najelith
-- Type: Galeserpent General
-- !pos -64.526 -8 39.372 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(269)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
