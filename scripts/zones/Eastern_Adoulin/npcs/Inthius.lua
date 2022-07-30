-----------------------------------
-- Area: Eastern Adoulin
-- NPC: Inthius
-- Type: Weather Reporter
-- !pos -97.3680 0.0000 -34.3807
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(4, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
