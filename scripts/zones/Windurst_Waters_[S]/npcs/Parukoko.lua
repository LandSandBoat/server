-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Parukoko
-- !pos -32.400 -3.5 -103.666 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(436)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
