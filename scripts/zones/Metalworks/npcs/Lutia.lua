-----------------------------------
-- Area: Metalworks
--  NPC: Lutia
-- Type: Standard NPC
-- !pos 24.076 -17 -33.060 237
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(202)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
