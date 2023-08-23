-----------------------------------
-- Area: Windurst Woods
--  NPC: Hayah Dahbalesahma
-- !pos -50.363 -1.292 -147.883 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(263)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
