-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Gadimo
-- Chocobobet Center Clerk
-- pos -370.9947 -4.0000 -453.0245
-- event 308 312
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