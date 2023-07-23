-----------------------------------
-- Area: Castle Oztroja
--  NPC: Daa Bola the Seer
-- Type: Quest NPC
-- !pos -157.978 -18.179 193.458 151
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(86)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
