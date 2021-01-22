-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Chat Manual
-- Type: Tutorial NPC
-- !pos -22.420 0.004 -46.880 243
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(6106)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
