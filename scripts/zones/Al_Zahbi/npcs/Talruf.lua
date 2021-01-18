-----------------------------------
-- Area: Al Zahbi
--  NPC: Talruf
-- Type: Standard NPC
-- !pos 100.878 -7 14.291 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(243)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
