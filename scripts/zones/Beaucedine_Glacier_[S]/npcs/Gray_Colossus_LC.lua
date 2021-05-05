-----------------------------------
-- Area: Beaucedine Glacier (S)
--  NPC: Gray Colossus, L.C.
-- Type: Campaign Arbiter
-- !pos 76.178 -60.763 -48.775 136
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(451)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
