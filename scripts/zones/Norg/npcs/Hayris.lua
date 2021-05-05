-----------------------------------
-- Area: Norg
--  NPC: Hayris
-- Type: Standard NPC
-- !pos 45.296 -7.282 12.267 252
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(215)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
