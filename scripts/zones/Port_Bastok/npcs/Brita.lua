-----------------------------------
-- Area: Port Bastok
--  NPC: Brita
-- Type: Standard NPC
-- !pos 58.161 -3.101 -6.695 236
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(346, 0, 1)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
