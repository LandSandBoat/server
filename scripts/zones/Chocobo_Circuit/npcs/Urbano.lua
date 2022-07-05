-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Urbano
-- Race Overview
-- pos -14.3511 -15.0000 -131.1869
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(337)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity