-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Jufaue
-- Type: Past Event Watcher
-- !pos 13.221 -1.199 -19.231 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(715)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
