-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Azainnie
-- !pos -60.623 -14.500 -133.451 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(328, 1) -- Exits to Ilsoire
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
