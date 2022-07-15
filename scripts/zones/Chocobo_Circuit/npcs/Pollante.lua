-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Pollante
-- Teleporter
-- pos -327.0122 -4.0000 -4.31.0164
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
