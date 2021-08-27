-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Pontaudarme
-- Type: Standard Info NPC
-- !pos -51.628 -0.199 16.593 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(717)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
