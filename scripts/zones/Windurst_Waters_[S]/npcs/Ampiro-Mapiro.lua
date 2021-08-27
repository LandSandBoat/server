-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Ampiro-Mapiro
-- Type: Standard NPC
-- !pos 131.380 -6.75 174.169 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(423)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
