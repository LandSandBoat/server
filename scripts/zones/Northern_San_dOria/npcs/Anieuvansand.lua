-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Anieuvansand
-- Type: Standard Info NPC
-- !pos -18.608 -0.199 83.911 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(665)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
