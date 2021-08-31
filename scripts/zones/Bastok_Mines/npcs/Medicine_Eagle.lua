-----------------------------------
-- Area: Bastok Mines
--  NPC: Medicine Eagle
-- Involved in Mission: Bastok 6-1, 8-1
-- !pos -40 0 38 234
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

-- if Bastok Mission 8-1
-- 176
-- player:startEvent(180)
-- player:startEvent(181)
--1  25  176  181  180
entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
