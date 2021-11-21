-----------------------------------
-- Area: Rala Waterways (258)
--  NPC: Yeggha Dolashi
-- !pos 260.000 -5.768 60.000 258
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(319)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
