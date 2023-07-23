-----------------------------------
-- Area: Windurst Woods
--  NPC: Mokop-Sankop
-- Type: Conquest Troupe
-- !pos 11.542 1.05 -53.217 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(50)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
