-----------------------------------
-- Area: Eastern Adoulin !zone 257
-- NPC: Inthius
-- Type: Weather Reporter
-- !pos -97.145 0.001 -36.710 257
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(4, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
