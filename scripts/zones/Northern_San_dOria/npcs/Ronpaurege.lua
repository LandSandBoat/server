-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Ronpaurege
-- Type: Standard Info NPC
-- !pos 65.739 -0.199 74.275 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(669)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
