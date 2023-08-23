-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Upital-Lupital
-- !pos -57.809 -13.339 122.753 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(439)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
