-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Cordaurie
-- !pos -253.318 -4.000 -509.032 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(287, 291, 292, 293, 294, 295, 300, 304)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
