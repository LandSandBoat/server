-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Fhaht Beablrucch
-- Betting Attendant (Red)
-- pos 
-- event 212 213 214 215 219 223 228 234
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