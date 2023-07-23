-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  NPC: Yve'noile
-- Type: Quest Giver
-- !pos 0.001 -1 0.001 178
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(53)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
