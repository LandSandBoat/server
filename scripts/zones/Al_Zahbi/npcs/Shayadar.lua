-----------------------------------
-- Area: Al Zahbi
--  NPC: Shayadar
-- Type: Gadalar's Attendant
-- !pos -107.177 -6.999 33.463 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(252)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
