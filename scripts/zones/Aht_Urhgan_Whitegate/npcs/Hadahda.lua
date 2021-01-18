-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Hadahda
-- Type: Standard NPC
-- !pos -112.029 -6.999 -66.114 50
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(518)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
