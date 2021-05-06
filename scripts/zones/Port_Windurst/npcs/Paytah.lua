-----------------------------------
-- Area: Port Windurst
--  NPC: Paytah
-- Type: Standard NPC
-- !pos 77.550 -6 117.769 240
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(288)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
