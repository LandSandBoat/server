-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Churacoco
-- Type: Standard NPC
-- !pos -76.139 -4.499 20.986 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(434)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
