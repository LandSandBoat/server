-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Berthold
-- Spectator [Roams]
-- pos -85.8890 -15.0901 -124.7663
-- event 359 360 361
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(359)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity