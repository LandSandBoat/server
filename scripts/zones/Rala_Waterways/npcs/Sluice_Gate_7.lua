-----------------------------------
-- Area: Rala Waterways (258)
--  NPC: Sluice Gate #7 (Secret Hideout Exit)
-- !pos TODO 258
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(362)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
