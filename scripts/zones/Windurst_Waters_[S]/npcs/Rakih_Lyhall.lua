-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Rakih Lyhall
-- !pos -48.111 -4.5 69.712 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(429)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
