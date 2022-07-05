-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Cadwyn
-- Betting Attendant (Green)
-- pos -314.0362 -4.0000 -425.4313
-- event 212 213 214 215 218 222 228 233
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(212)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
