-----------------------------------
-- Area: Al Zahbi
--  NPC: Dahaeel
-- Type: Standard NPC
-- !pos -58.732 -6.999 68.096 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(264)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
