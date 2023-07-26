-----------------------------------
-- Area: Al Zahbi
--  NPC: Dabigo
-- Type: Delivery Box Manager
-- !pos -34.289 -1 -129.141 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(210)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
