-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Papal Chambers
-- Finish Mission: The Davoi Report
-- !pos 131 -11 122 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- This NPC is relevant only to San d'Orians on missions and has no default
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
