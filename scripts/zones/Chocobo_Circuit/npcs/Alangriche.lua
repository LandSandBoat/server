-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Alangriche
-- Novice San d'Oria CRA Branch
-- pos -499.454 0.000 -369.042
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(420)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
