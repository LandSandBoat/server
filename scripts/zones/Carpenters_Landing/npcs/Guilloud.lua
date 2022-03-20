-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Guilloud
-- Involved with mission "The Road Forks"
-- !pos -123.770 -6.654 -469.062 2
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(1)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
