-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ceraule
--  General Info NPC
-- !pos -86 2 -35 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(509)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
