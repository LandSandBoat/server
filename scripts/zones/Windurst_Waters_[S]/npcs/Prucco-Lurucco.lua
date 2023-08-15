-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Prucco-Lurucco
-- !pos 140.772 -3.499 132.942 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(420)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
