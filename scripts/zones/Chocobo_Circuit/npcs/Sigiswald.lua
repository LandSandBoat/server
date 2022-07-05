-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Sigiswald
-- Spectator [roams]
-- pos -111.7260 -11.500 -104.0905
-- event 362 363 364
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(363)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
