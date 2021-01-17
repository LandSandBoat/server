-----------------------------------
-- Area: Al Zahbi
--  NPC: Sujyahn
-- Type: Standard NPC
-- !pos -48.213 -1 34.723 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(242)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
