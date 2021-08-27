-----------------------------------
-- Area: Al Zahbi
--  NPC: Hadibal
-- Type: Standard NPC
-- !pos -34.345 -1 -38.842 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(245)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
