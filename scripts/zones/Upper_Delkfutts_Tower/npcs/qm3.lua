-----------------------------------
-- Area: Upper Delkfutt's Tower
--  NPC: ???
-- Notes: Teleports you to the 10th floor.
-- !pos 261 19 20 158
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(17)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
