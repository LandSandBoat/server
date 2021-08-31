-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Rakh Mhappyoh
-- Type: Standard NPC
-- !pos -55.989 -4.5 48.365 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(411)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
