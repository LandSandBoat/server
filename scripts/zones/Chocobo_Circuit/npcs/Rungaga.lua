-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Rungaga
-- Novice Windurst CRA Branch
-- pos 
-- event 462 463 464 465 466 467 468 470 471 472 
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(462)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity