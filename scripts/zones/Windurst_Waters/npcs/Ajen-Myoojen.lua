-----------------------------------
-- Area: Windurst Waters
--  NPC: Ajen-Myoojen
-- Type: Standard NPC
-- !pos -44.542 -5.999 238.996 238
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(270)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
