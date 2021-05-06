-----------------------------------
-- Area: Windurst Woods
--  NPC: Erpolant
-- Type: Standard NPC
-- !pos -63.224 -0.749 -33.424 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(444)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
