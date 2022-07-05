-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Odersille
-- Grandstand Exit
-- pos -14.3511 -15 -131.869
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(331)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity