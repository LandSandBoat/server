-----------------------------------
-- Area: Mhaura
--  NPC: Bihoro-Guhoro
-- Involved in Quest: Riding on the Clouds
-- !pos -28 -8 41 249
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(750)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
