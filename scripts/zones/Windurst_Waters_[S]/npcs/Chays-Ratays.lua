-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Chays-Ratays
-- !pos -6.013 -4.999 -185.219 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(401)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
