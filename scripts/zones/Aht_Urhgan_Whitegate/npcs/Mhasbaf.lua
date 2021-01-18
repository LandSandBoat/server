-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Mhasbaf
-- Type: Standard NPC
-- !pos 54.701 -6.999 11.387 50
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(542)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
