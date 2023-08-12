-----------------------------------
-- Area: Bastok Mines
--  NPC: Gorvik
-- Type: Past Event Watcher
-- !pos 21.033 -1 -98.486 234
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(185)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
