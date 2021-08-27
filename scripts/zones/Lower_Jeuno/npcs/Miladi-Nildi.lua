-----------------------------------
-- Area: Lower Jeuno
--  NPC: Miladi-Nildi
-- Type: Standard NPC
-- !pos 39.898 -5.999 77.190 245
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(97)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
