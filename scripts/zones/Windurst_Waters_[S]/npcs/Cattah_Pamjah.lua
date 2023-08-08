-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Cattah Pamjah
-- Type: Title Changer
-- !pos -13.564 -2 10.673 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(137)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
