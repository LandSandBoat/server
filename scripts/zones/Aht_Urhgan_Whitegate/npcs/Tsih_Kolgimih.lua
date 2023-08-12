-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Tsih Kolgimih
-- Type: Event Scene Replayer
-- !pos -143.000 0.999 11.000 50
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(807)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
