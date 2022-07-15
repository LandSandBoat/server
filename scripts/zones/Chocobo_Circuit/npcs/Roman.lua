-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Roman
-- Standard Info NPC
-- POS: -10.0760 0 -134.7784
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(287)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
