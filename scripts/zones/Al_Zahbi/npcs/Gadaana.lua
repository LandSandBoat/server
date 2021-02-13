-----------------------------------
-- Area: Al Zahbi
--  NPC: Gadaana
-- Type: Standard NPC
-- !pos 18.596 -1 -29.891 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(244)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
