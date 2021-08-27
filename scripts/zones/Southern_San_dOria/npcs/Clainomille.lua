-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Clainomille
-- Type: Standard NPC
-- !pos -72.771 0.999 -6.112 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(613)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
