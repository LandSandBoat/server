-----------------------------------
-- Area: La Theine Plateau
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos 334.133 50.623 141.163 102
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
