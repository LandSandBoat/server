-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Tohs Jhannih
-- Type: Standard NPC
-- !pos -46.492 -4.5 70.828 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(430)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
