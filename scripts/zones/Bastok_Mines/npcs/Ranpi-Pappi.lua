-----------------------------------
-- Area: Bastok Mines
--  NPC: Ranpi-Pappi
-- !pos -4.535 -1.044 49.881 234
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(77)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
