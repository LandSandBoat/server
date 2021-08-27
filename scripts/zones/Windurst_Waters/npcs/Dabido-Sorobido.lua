-----------------------------------
-- Area: Windurst Waters
--  NPC: Dabido-Sorobido
-- Type: Standard NPC
-- !pos -93.586 -4.499 19.321 238
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(904)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
