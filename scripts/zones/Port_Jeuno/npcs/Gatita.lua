-----------------------------------
-- Area: Port Jeuno
--  NPC: Gatita
-- Type: Standard NPC
-- !pos -60.207 7.002 -59.143 246
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(44)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
