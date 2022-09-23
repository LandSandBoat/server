-----------------------------------
-- Area: Bastok Markets
--  NPC: Domhnall
-- Type: Standard Info NPC
-- !pos -104.611 -5.825 -81.531 235
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(117)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
