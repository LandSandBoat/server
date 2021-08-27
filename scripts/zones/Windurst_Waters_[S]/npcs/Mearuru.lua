-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Mearuru
-- Type: Standard NPC
-- !pos 153.798 -1 153.712 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(418)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
