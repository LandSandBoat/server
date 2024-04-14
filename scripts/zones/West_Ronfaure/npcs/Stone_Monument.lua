-----------------------------------
-- Area: West Ronfaure
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos -183.734 -12.678 -395.722 100
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
