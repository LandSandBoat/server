-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Uricca-Koricca
-- Type: Standard NPC
-- !pos -102.221 -3 48.791 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(437)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
