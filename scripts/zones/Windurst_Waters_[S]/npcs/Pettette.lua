-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Pettette
-- !pos 164.026 -0.001 -26.690 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(9)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
