-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos 320.755 -4.000 368.722 118
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
