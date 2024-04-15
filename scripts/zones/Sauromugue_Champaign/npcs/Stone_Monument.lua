-----------------------------------
-- Area: Sauromugue Champaign
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos 77.544 -2.746 -184.803 120
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
