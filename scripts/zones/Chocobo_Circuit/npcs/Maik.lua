-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Maik
-- Spectator [Roam]
-- pos -105.6099 -11.5000 -102.6501
-- event 374 375 376
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(374)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
