-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Quartermaster
-- Type: Standard NPC
-- !pos -60.200 -4.7 32.500 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(201)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
