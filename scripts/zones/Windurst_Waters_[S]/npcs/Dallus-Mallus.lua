-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Dallus-Mallus
-- Type: Campaign Intel Advisor
-- !pos -13.666 -2 26.180 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(323)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
