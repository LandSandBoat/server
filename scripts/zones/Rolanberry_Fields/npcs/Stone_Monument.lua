-----------------------------------
-- Area: Rolanberry Fields
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos 362.479 -34.894 -398.994 110
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
