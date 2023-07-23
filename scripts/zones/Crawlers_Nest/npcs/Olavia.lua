-----------------------------------
-- Area: Crawlers' Nest
--  NPC: Olavia
-- Type: Escort NPC
-- !pos 379.638 -33.051 -0.533 197
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(6)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
