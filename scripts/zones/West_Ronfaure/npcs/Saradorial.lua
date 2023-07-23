-----------------------------------
-- Area: West Ronfaure
--  NPC: Saradorial
-- Type: Goldfish Scooping
-- !pos -399.671 -10.999 -438.910 100
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(139)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
