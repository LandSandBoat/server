-----------------------------------
-- Area: Monastic Cavern
--  NPC: Loo Kohor
-- Type: Quest NPC
-- !pos -48.744 -17.741 -104.954 150
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(5)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
