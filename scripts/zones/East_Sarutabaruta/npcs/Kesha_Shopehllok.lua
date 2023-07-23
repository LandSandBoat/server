-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Kesha Shopehllok
-- Type: Goldfish Scooping
-- !pos -22.316 -2.79 -50.815 116
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(55)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
