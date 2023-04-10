-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Pollante
-- !pos -325.119 -4.000 -430.698 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(237)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
