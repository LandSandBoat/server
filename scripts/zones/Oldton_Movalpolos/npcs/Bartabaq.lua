-----------------------------------
-- Area: Oldton Movalpolos
--  NPC: Bartabaq
-- Type: Outpost Vendor
-- !pos -261.930 6.999 -49.145 11
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(32756)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
