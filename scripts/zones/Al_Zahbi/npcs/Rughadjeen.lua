-----------------------------------
-- Area: Al Zahbi
--  NPC: Rughadjeen
-- Type: Skyserpent General
-- !pos -74.150 -7 70.656 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(265)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
