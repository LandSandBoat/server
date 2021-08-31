-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Rainhard
-- Type: Standard NPC
-- !pos -2.397 -5.999 68.749 243
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(34)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
