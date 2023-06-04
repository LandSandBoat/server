-----------------------------------
-- Area: Rabao
--  NPC: Amaja-Kumaja
-- Type: Weather Reporter
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(1005, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
