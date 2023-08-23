-----------------------------------
-- Area: Port San d'Oria
--  NPC: Dabbio
-- !pos -7.819 -15 -106.990 232
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(722)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
