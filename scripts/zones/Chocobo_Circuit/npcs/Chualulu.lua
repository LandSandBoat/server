-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Chualulu
-- Expert Windurst CRA Branch
-- pos 
-- event 491 492 493 494 495 496 497 498 499
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(491)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity