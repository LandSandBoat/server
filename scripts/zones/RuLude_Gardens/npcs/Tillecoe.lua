-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Tillecoe
-- !pos 38.528 -0.997 -6.363 243
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(70)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
