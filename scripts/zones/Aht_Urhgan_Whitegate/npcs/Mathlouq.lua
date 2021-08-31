-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Mathlouq
-- Type: Standard NPC
-- !pos -92.892 -7 129.277 50
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(543)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
