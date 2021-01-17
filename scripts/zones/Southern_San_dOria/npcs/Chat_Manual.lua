-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Chat Manual
-- Type: Tutorial NPC
-- !pos -68.800 2.000 -46.560 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(6106)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
