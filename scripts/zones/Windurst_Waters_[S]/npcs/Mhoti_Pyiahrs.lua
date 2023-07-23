-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Mhoti Pyiahrs
-- Type: Allegiance
-- !pos 6.356 -2 26.677 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(2)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
