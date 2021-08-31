-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Pursuivant
-- Type: Standard NPC
-- !pos 54.000 -1.199 11.937 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(760)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
