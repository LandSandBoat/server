-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Failene
-- Betting Attendant (Blue)
-- pos 
-- event 212 213 214 215 217 221 228  232
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