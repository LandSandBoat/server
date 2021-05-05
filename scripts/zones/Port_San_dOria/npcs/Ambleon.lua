-----------------------------------
-- Area: Port San d'Oria
--  NPC: Ambleon
-- Type: NPC World Pass Dealer
-- !pos 71.622 -17 -137.134 232
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(710)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
