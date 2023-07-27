-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ephauge
--  General Info NPC
-- !pos -2 -2 45 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(581)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
