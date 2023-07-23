-----------------------------------
-- Area: Windurst Woods
--  NPC: Istvan
-- Type: ENM Quest Timer
-- !pos 116.294 -6 -98.164 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(692)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
