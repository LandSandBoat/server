-----------------------------------
-- Area: Selbina
--  NPC: Ramona
-- !pos 12.511 -7.287 2.939 248
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(170)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
