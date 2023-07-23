-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Soimin-Oimin, C.C.
-- Type: Retrace
-- !pos -51.010 -6.276 213.678 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(452)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
