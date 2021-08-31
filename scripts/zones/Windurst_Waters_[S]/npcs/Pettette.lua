-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Pettette
-- Type: Standard NPC
-- !pos 164.026 -0.001 -26.690 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(9)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
