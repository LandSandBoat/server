-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Velda-Galda
-- Type: Mission NPC
-- !pos 138.631 -3.112 61.658 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(177)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
