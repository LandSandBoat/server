-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Charmealaut
-- Type: Merchant
-- !pos 0.000 -0.501 29.303 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(768)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
