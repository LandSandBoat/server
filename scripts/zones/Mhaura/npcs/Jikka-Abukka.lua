-----------------------------------
-- Area: Mhaura
--  NPC: Jikka-Abukka
-- Involved in Quest: Riding on the Clouds
-- !pos -13 -15 58 249
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(600)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
