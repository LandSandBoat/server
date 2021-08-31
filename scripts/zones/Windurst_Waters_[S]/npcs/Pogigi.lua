-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Pogigi
-- Type: Sealed Container
-- !pos -29.787 -4.499 42.603 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(330)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
