-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Rakh Mhappyoh
-- !pos -55.989 -4.5 48.365 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(411)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
