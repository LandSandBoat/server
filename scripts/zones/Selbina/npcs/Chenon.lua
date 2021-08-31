-----------------------------------
-- Area: Selbina
--  NPC: Chenon
-- Type: Fish Ranking NPC
-- !pos -13.472 -8.287 9.497 248
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10010)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
