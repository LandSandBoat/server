-----------------------------------
-- Area: Upper Jeuno
--  NPC: Zekobi-Morokobi
-- !pos 41.258 -5.999 -74.105 244
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(87)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
