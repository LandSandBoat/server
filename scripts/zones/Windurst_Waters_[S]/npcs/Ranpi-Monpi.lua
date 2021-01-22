-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Ranpi-Monpi
-- Type: Standard NPC
-- !pos -115.452 -3 43.389 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(117)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
