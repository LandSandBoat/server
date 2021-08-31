-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Kleh Engyumoh
-- Type: Standard NPC
-- !pos -54.962 -4.5 57.701 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(431)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
