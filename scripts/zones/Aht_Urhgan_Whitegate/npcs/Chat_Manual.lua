-----------------------------------
-- Area: Aht Urgan Whitegate
--  NPC: Chat Manual
-- Type: Tutorial NPC
-- !pos -5.440 0 -11.449 50
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(6106)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
