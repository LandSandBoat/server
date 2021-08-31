-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Tillecoe
-- Type: Standard NPC
-- !pos 38.528 -0.997 -6.363 243
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(70)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
