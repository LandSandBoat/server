-----------------------------------
-- Area: East Ronfaure
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos 77.277 -2.894 -517.376 101
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

entity.onTrade = function(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
