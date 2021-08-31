-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Rakih Lyhall
-- Type: Standard NPC
-- !pos -48.111 -4.5 69.712 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(429)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
