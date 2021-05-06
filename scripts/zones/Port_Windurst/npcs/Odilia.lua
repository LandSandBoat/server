-----------------------------------
-- Area: Port Windurst
--  NPC: Odilia
-- Type: Standard NPC
-- !pos 78.801 -6 118.653 240
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(289)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
