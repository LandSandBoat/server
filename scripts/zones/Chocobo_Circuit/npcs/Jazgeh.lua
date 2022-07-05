-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Jazgeh
-- Novice Bastok CRA Branch
-- pos
-- event 451 452 454 455 456 457 458 460 461
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(451)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
