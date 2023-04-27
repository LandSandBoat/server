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
--    player:startEvent(137)
    player:PrintToPlayer("Title NPC's have been disabled to prevent exploiting weekly HNM hunts.")
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
