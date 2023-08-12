-----------------------------------
-- Area: Jugner Forest
--  NPC: Perevie
-- Type: Armor Storer
-- !pos 5.190 -0.647 11.563 104
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(29)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
