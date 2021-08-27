-----------------------------------
-- Area: Al Zahbi
--  NPC: Devonte
-- Type: Standard NPC
-- !pos 29.449 -1 142.671 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(249)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
