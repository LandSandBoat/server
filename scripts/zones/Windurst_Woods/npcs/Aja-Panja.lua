-----------------------------------
-- Area: Windurst Woods
--  NPC: Aja-Panja
-- Type: Standard NPC
-- !pos -7.251 -6.55 -134.127 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(247)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
