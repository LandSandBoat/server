-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Matifa
-- Type: Standard NPC
-- !pos -10.583 -1 -8.820 50
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(541)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
