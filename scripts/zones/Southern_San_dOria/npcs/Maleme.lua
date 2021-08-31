-----------------------------------
-- Area: Southern San dOria
--  NPC: Maleme
-- Type: Weather Reporter
-- Involved in Quest: Flyers for Regine
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(632, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
