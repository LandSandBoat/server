-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Icoua
-- Type: Standard NPC
-- !pos 87.719 -1 9.256 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(674)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
