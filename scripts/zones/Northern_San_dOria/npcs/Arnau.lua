-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Arnau
-- Involved in Mission: Save the Children
-- !pos 148 0 139 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(20)
    -- CS 520 default while RoV M1-3 active?
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
