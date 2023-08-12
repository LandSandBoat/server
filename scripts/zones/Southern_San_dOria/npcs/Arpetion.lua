-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Arpetion
--  General Info NPC
-- !pos -11 1 -30 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(660)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
