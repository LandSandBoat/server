-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Ekki-Mokki
-- !pos -26.558 -4.5 62.930 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(409)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
