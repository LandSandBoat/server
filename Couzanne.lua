-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Couzanne
-- !pos -107.947 -14.500 -133.451 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(332, 5) --
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
