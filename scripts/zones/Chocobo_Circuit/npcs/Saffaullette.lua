-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Saffaullette
-- Chocobo Circuit Grandstand Attendant
-- pos -252.2906 -5.0000 -490.7443

-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(265)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity