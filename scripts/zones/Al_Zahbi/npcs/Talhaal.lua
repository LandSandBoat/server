-----------------------------------
-- Area: Al Zahbi
--  NPC: Talhaal
-- Type: Zazarg's Attendant
-- !pos -35.897 -7 107.160 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(256)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
