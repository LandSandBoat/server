-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Synergy Engineer
-- Type: Standard NPC
-- !pos -123.000 10.5 244.000 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(11002)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
