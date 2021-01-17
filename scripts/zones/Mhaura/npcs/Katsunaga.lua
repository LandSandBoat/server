-----------------------------------
-- Area: Mhaura
--  NPC: Katsunaga
-- Type: Standard NPC
-- !pos -4.726 -2.148 23.183 249
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(190)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
