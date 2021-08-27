-----------------------------------
-- Area: Windurst Woods
--  NPC: Bozack
-- Type: Event Replayer
-- !pos 92.591 -5.58 -31.529 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(612)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
