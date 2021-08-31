-----------------------------------
-- Area: Quicksand Caves
--  NPC: Goblin Geologist
-- Type: Mission
-- !pos -737.000 -11.125 -550.000 208
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(100)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
