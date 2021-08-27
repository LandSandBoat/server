-----------------------------------
-- Area: Windurst Waters
--  NPC: Chyuk-Kochak
-- Type: Standard NPC
-- !pos -252.162 -6.319 -307.011 238
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(664)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
