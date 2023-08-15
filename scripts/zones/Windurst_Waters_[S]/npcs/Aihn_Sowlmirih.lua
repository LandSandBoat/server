-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Aihn Sowlmirih
-- !pos -61.102 -4.5 71.743 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(412)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
