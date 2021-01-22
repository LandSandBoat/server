-----------------------------------
-- Area: Western Adoulin
--  NPC: Chat Manual
-- Type: Tutorial NPC
-- !pos 28.790 0 -143.440 256
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
