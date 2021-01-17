-----------------------------------
-- Area: Windurst Woods
--  NPC: Nalta
-- Type: Conquest Troupe
-- !pos 19.140 1 -51.297 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(54)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
