-----------------------------------
-- Area: Bastok Mines
--  NPC: Christina
-- Type: Special Event Coordinator
-- !pos 23.703 -1 -86.034 234
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(32690)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
