-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Lafaurelle
-- Expert San d'Oria CRA Branch
-- pos 
-- event 473 474 475 476 477 478 479 480 481 
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(473)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
