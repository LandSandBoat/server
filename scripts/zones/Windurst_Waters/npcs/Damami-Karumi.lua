-----------------------------------
-- Area: Windurst Waters
--  NPC: Damami-Karumi
-- Type: Standard NPC
-- !pos -5.362 -2 18.059 238
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(575)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
