-----------------------------------
-- Area: Bastok Mines
--  NPC: Leonie
-- Type: Room Renters
-- !pos 118.871 -0.004 -83.916 234
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(568)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
