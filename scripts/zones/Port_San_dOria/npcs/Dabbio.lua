-----------------------------------
-- Area: Port San d'Oria
--  NPC: Dabbio
-- Type: Standard NPC
-- !pos -7.819 -15 -106.990 232
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(722)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
