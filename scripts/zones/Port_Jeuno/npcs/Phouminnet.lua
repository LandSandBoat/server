-----------------------------------
-- Area: Port Jeuno
--  NPC: Prouminnet
-- !pos -81 8 53 246
-----------------------------------
local ID = zones[xi.zone.PORT_JEUNO]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.DEPARTURE_NPC)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
