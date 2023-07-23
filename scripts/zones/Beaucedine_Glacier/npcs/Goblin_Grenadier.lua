-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Goblin Grenadier
-- Type: Mission NPC
-- !pos -26.283 -60.49 -76.640 111
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(509)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
