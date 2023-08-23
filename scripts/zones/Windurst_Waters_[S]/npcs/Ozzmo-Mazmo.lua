-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Ozzmo-Mazmo
-- !pos -61.677 -13.311 106.400 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(432)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
