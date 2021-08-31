-----------------------------------
-- Area: Al Zahbi
--  NPC: Mihli Aliapoh
-- Type: Waterserpent General
-- !pos -22.615 -7 78.907 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(267)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
