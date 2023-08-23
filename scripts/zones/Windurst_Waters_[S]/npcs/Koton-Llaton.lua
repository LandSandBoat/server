-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Koton-Llaton
-- !pos 78.220 -3.75 -173.631 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(402)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
