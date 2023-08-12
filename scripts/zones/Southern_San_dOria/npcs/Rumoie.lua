-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Rumoie
-- Type: Map Marker NPC
-- !pos 149.696 -2.000 151.631 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(863)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
