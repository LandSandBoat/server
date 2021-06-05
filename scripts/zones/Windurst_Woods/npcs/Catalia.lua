-----------------------------------
-- Area: Windurst Woods
--  NPC: Catalia
-- Type: Standard NPC
-- !pos -46.160 -0.501 -32.698 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(442)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
