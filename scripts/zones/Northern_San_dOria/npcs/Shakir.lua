-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Shakir
-- Type: Standard NPC
-- !pos 48.952 -2.999 -16.687 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(538)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
