-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Rondipur
-- Type: Quest Giver
-- !pos -154.415 10.999 153.744 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(721)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
