-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Ruirara
-- Type: Standard NPC
-- !pos -87.378 -2 -158.019 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(435)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
