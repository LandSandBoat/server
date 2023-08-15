-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Sahnn Dhansett
-- !pos 112.820 -3.122 47.857 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(417)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
