-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Gevarg
-- Type: Past Event Watcher
-- !pos -46.448 -6.312 212.384 94
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
