-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Guillaulmilian
-- Chocobobet Center Clerk
-- POS: -61.8841 -15.0000 -105.7313 [top and bottom?]
-- POS: -378.2096 -4.0000 -451.4200
-- event 308 312 316 320
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(308)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity