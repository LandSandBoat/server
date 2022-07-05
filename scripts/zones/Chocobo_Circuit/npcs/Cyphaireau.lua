-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Cyphaireau
-- Teleporter
-- POS: -369.2226 -4.0000 -492.1980
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(240)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
