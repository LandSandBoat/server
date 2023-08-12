-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Esmallegue
--  General Info NPC
-- !pos 0 2 -83 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
-- player:startEvent(894)-- cavernous maw
    player:startEvent(885)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
