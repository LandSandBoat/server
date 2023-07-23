-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Marshal
-- !pos 41.143 -0.998 -26.566 243
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(44)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
