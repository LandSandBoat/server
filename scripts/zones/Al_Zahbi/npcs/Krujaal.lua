-----------------------------------
-- Area: Al Zahbi
--  NPC: Krujaal
-- Type: Residence Renter
-- !pos 36.522 -1 -63.198 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(0)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
