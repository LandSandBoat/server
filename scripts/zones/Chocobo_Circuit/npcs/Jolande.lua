-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Jolande
-- !pos -499.440 0.000 -371.312 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(346)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
