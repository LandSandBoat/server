-----------------------------------
-- Area: Windurst Woods
--  NPC: Catalia
-- !pos -46.160 -0.501 -32.698 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(442)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
