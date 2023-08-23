-----------------------------------
-- Area: Windurst Woods
--  NPC: Aja-Panja
-- !pos -7.251 -6.55 -134.127 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(247)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
