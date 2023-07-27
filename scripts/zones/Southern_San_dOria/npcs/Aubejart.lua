-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Aubejart
--  General Info NPC
-- !pos 3 -2 46 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(582)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
