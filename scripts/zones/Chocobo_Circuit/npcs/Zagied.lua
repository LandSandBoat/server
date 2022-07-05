-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Zagied
-- Expert Bastok CRA Branch
-- pos 
-- event 482 483 484 485 486 487 488 489 490
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(482)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
