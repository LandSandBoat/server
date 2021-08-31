-----------------------------------
-- Area: Port Jeuno
--  NPC: Moulloie
-- Type: Standard NPC
-- !pos -77.724 7.003 59.044 246
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(46)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
