-----------------------------------
-- Area: Al Zahbi
--  NPC: Eumoa-Tajimoa
-- Type: Standard NPC
-- !pos 19.275 -1 55.182 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(239)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
