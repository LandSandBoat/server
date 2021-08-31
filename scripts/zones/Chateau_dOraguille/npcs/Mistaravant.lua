-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Mistaravant
-- Type: Standard NPC
-- !pos 7.097 -3.999 67.988 233
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(524)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
