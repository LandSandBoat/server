-----------------------------------
-- Area: Jugner Forest (S)
--  NPC: Gate Sentry
-- !pos -265.235 -2.399 405.246 82
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(253)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
