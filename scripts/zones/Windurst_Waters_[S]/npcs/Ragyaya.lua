-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Ragyaya
-- Type: Standard NPC
-- !pos -95.376 -3 60.795 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(406)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
