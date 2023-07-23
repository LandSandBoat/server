-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Heumila
-- Type: Past Event Watcher
-- !zone 87
-- !pos
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(0)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
