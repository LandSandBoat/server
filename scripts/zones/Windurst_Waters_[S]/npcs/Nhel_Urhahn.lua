-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Nhel Urhahn
-- Type: Standard NPC
-- !pos -47.348 -4.499 47.117 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(416)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
