-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Kopol-Rapol
-- Type: Standard NPC
-- !pos 131.179 -6.75 172.758 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(422)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
