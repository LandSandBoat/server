-----------------------------------
-- Area: Uleguerand Range
--  NPC: Buffalostalker Dodzbraz
-- Type: Quest NPC
-- !pos -380.171 -24.89 -180.797 5
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(6)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
