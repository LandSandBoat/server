-----------------------------------
-- Area: Silver_Sea_route_to_Al_Zahbi
--  NPC: Map
-- !pos 0.340 -12.232 -4.120 58
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(1024)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
