-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Mistaravant
-- !pos 7.097 -3.999 67.988 233
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(524)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
