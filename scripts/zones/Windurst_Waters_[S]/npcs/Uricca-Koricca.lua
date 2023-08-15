-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Uricca-Koricca
-- !pos -102.221 -3 48.791 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(437)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
