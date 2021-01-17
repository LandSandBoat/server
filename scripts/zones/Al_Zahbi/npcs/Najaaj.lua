-----------------------------------
-- Area: Al Zahbi
--  NPC: Najaaj
-- Type: Standard NPC
-- !pos 61.563 -1 36.264 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(241)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
