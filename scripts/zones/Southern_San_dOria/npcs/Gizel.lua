-----------------------------------
-- Area: Southern San dOria
--  NPC: Gizel
-- Type: Event Scene Replayer NPC
-- !pos -34.412 0.000 33.362 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(676)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
