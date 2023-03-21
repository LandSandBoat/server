-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Giancario
-- !pos -253.330 -4.000 -451.168 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(212, 213, 214, 215, 228, 229, 230, 231)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
