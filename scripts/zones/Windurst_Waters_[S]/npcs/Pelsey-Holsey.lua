-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Pelsey-Holsey
-- !pos 119.755 -4.5 209.754 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(419)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
