-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Coderiant
--  General Info NPC
-- !pos -111 -2 33 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(583)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
