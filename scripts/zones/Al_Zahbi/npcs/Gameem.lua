-----------------------------------
-- Area: Al Zahbi
--  NPC: Gameem
-- Type: Standard NPC
-- !pos 18.813 -7 11.298 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(236)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
