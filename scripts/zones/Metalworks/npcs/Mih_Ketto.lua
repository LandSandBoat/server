-----------------------------------
-- Area: Metalworks
--  NPC: Mih Ketto
-- Type: Standard NPC
-- !pos 24.046 -17 32.751 237
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(253)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
