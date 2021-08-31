-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Ponono
-- Type: Standard NPC
-- !pos 156.069 -0.001 -15.667 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(193)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
