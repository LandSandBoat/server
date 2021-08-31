-----------------------------------
-- Area: Windurst Waters
--  NPC: Pursuivant
-- Type: Pursuivant
-- !pos 113.971 -3.077 51.524 238
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(870)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
